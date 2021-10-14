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
    //        return AF.request(route).responseDecodable (decoder: decoder) {
    //            (response: DataResponse<T, AFError>) in
    //
    //            print(response.debugDescription)
    //            // TODO - 상속을 통해 header의 세션 만료를 한군데서 처리 가능하도록 하던지 모든 api에서 처리 필요.
    //            switch response.result {
    //            case .success(let response):
    //                if let header = try? (response as? ResponseHeaderProtocol)?.getResponseHeader() {
    //                    if header.Code == ServerCode.sessionTimeout.rawValue {
    //                        if !isShownAuthErrPopup {
    //                            isShownAuthErrPopup = true
    //                            CommonPopupType1_2.showSessionClose({
    //                                isShownAuthErrPopup = false
    //                            })
    //                        }
    //                        return
    //                    }
    //                }
    //            case .failure( _):
    //                break
    //            }
    //            completion(response.result)
    //        }
    //    }
    
    /**
     세션 요청 암호화 key 수취 (3.1.1)
     */
    static func session(completion: @escaping (Result<ResponseSession, AFError>) -> Void) {
        performRequest(route: APIs.session(P01: UUID().uuidString.replacingOccurrences(of: "-", with: "")), completion: completion)
    }
    
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

