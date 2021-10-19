//
//  ApiListData.swift
//  NetworkModule
//
//  Created by 육승현 on 2021/10/20.
//

import Foundation

class ApiListData: Codable {
    var apiImgUrl: String?
    var apiDescription: String?
    var isSuccess: Bool?
    
    init() {
    }
    
//    enum CodingKeys: String, CodingKey {
//        case apiImgUrl = "apiImgUrl"
//        case apiDescription = "apiDescription"
//        case isSuccess = "isSuccess"
//    }
}
