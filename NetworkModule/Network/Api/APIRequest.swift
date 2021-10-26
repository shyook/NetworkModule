//
//  APIRequest.swift
//  NetworkModule
//
//  Created by 육승현 on 2021/10/14.
//

import Alamofire

class APIRequest {
    @discardableResult
    private static func performRequest<T:Decodable>(route:APIs, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T, AFError>)->Void) -> DataRequest {
        return AF.request(route).responseDecodable (decoder: decoder) { (response: DataResponse<T, AFError>) in completion(response.result)
            
            print(response.debugDescription)
        }
    }
    
    /*
     세션 요청 API (Get 방식)
     */
    static func session(completion: @escaping (Result<ResponseSession, AFError>) -> Void) {
        performRequest(route: APIs.session(P01: UUID().uuidString.replacingOccurrences(of: "-", with: "")), completion: completion)
    }
    
    /*
     로그인 요청 API (Post 방식)
     */
    static func login(id: String, password: String, completion: @escaping (Result<ResponseBase, AFError>) -> Void) {
        performRequest(route: APIs.login(P01: id, P02: password), completion: completion)
    }
}

extension DataResponse {
    public var debugDescription: String {
        #if DEBUG
        let requestAPI = request.map { "\($0.httpMethod!) \($0)" } ?? "nil"
        let requestHeader = request.map { "\($0.headers.sorted())" } ?? "nil"
        let requestBody = request?.httpBody.map {
            guard let object = try? JSONSerialization.jsonObject(with: $0, options: []),
                let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
                let prettyPrintedString = String(data: data, encoding: .utf8) else {
                    return "None"
            }
            return prettyPrintedString // Json을 보기 좋게 표시
        } ?? "None"
        let responseCode = response.map { "\($0.statusCode)" } ?? "nil"
        let responseBody = data.map {
            guard let object = try? JSONSerialization.jsonObject(with: $0, options: []),
                let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
                let prettyPrintedString = String(data: data, encoding: .utf8) else {
                    return "None"
            }
            return prettyPrintedString // Json을 보기 좋게 표시
        } ?? "None"
        let metricsDescription = metrics.map { "\($0.taskInterval.duration)s" } ?? "None"
        
        return """
        [Request API]: \(requestAPI)
        [Request Header]: \n\(requestHeader)
        [Request Body]: \n\(requestBody)
        [Response Status Code]: \(responseCode)
        [Response Body]: \n\(responseBody)
        [Network Duration]: \(metricsDescription)
        """
        #else
        return ""
        #endif
    }
}

