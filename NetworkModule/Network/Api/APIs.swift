//
//  APIs.swift
//  NetworkModule
//
//  Created by 육승현 on 2021/10/14.
//

import Alamofire

enum APIs: URLRequestConvertible, CaseIterable {
    static var allCases: [APIs] {
        return [.session(P01: ""), .login(P01: "", P02: "")]
    }
    
    
    case session(P01: String)
    case login(P01: String, P02: String)
    
    var name: String {
        switch self {
        case .session:
            return "session"
        case .login:
            return "login"
        }
    }
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .session:
            return .get
        case .login:
            return .post
        }
    }
    
    // MARK: - path
    private var path: String {
        let url = Server.ServerURL.baseURL
        
        switch self {
        case .session(let P01):
            return url + "/S001/01_01_01.do?P01=\(P01)"
        case .login:
            return url + "/L001/02_01_01.do"
        }
    }
    
    // MARK: - parameters
    private var parameters: Parameters? {
        switch self {
        case .login(let P01, let P02):
        return [Server.APIParameterKey.P01: P01, Server.APIParameterKey.P02: P02]
            
        default:
            // get 방식인 경우 nil을 리턴 한다.
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try path.asURL()
        var urlRequest = URLRequest(url: url)
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        // Parameters
        // get방식인 경우 nil return
        if let parameters = parameters {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        print(urlRequest.url?.absoluteString ?? "")
        
        return urlRequest
    }
}
