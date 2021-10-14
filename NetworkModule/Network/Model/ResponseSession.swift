//
//  ResponseSession.swift
//  NetworkModule
//
//  Created by 육승현 on 2021/10/14.
//

import Foundation


struct ResponseSession: Codable, ResponseHeaderProtocol {
    let header: ResponseBase.Header?
    let sessionBody: Body?
    
    struct Body: Codable {
        let encSeq: String?
        let encKey: String?
    }
    
    func getResponseHeader() -> ResponseBase.Header? {
        return header
    }
}
