//
//  ResponseBase.swift
//  NetworkModule
//
//  Created by 육승현 on 2021/10/14.
//

import Foundation

protocol ResponseHeaderProtocol {
    func getResponseHeader() -> ResponseBase.Header?
}

struct ResponseBase: Codable, ResponseHeaderProtocol {
    let header: Header?
    
    struct Header: Codable {
        let code: String?
        let message: String?
    }
    
    func getResponseHeader() -> ResponseBase.Header? {
        return header
    }
}
