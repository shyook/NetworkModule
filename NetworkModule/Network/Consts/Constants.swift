//
//  Constants.swift
//  NetworkModule
//
//  Created by 육승현 on 2021/10/14.
//

import Foundation

struct Server {
    struct ServerURL {
        static let REAL = "http://localhost"
        static let VERSION = "/api/v1"
        static let PORT = ":8070"
        
        static let baseURL = REAL + PORT + VERSION
    }
    
    struct APIParameterKey {
        static let P01 = "P01"
        static let P02 = "P02"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}

enum ServerCode: String {
    case success = "10000"
    case sessionTimeout = "22002"
}
