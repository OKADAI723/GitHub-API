//
//  ItemsModel.swift
//  GitHub-API
//
//  Created by Yudai Fujioka on 2021/07/11.
//

import Foundation

struct ItemsModel : Codable {
    let name: String
    let full_name: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case name
        case full_name = "full_name"
        case id
    }
}


