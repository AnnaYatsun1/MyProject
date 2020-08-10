//
//  CommentsModel.swift
//  TestLightIT
//
//  Created by Анна Яцун on 05.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import Foundation

struct CommentsModel: Codable {
    var id: Int?
    var product: Int?
    var rate: Int
    var text: String
    var created_by: UserDataModel?
}

struct UserDataModel: Codable {
    var id: Int
    var username: String
    var first_name: String?
    var last_name: String?
    var email: String?
    var password: String?
}

