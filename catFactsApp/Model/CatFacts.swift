//
//  CatFacts.swift
//  catFactsApp
//
//  Created by Ivan Obodovskyi on 1/6/19.
//  Copyright © 2019 Ivan Obodovskyi. All rights reserved.
//

import UIKit


struct CatsResponse: Codable {

    let catsArray: [CatData]
    
    enum CodingKeys: String, CodingKey {
        case catsArray = "all"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(catsArray, forKey: .catsArray)
    }

    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        catsArray = try container.decodeIfPresent(Array<CatData>.self, forKey: .catsArray) ?? [CatData]()
    }

}
struct CatData: Codable {
    let text: String
    let id: String
    let user: UserData

    enum CodingKeys: String, CodingKey {
        case text
        case id = "_id"
        case user
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(text, forKey: .text)
        try container.encode(id, forKey: .id)
        try container.encode(user, forKey: .user)
    }

    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        text = try container.decodeIfPresent(String.self, forKey: .text) ?? ""
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        user = try container.decodeIfPresent(UserData.self, forKey: .user) ?? UserData()
    }

}
struct UserData: Codable {
    let id: String
    let name: UserName

    enum CodingKeys: String, CodingKey {
        case name
        case id = "_id"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
    }
    
    init() {
        self.id = ""
        self.name = UserName()
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(UserName.self, forKey: .name) ?? UserName()
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
    }
    
}
struct UserName: Codable {
    let first: String
    let last: String
    
    enum CodingKeys: String, CodingKey {
        case first
        case last
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(first, forKey: .first)
        try container.encode(last, forKey: .last)
    }
    
    init() {
        self.first = ""
        self.last = ""
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        first = try container.decodeIfPresent(String.self, forKey: .first) ?? ""
        last = try container.decodeIfPresent(String.self, forKey: .last) ?? ""
    }
    
}


