//
//  APIResponse.swift
//  Cocktail
//
//  Created by Kevin Chan on 2020/8/27.
//  Copyright © 2020 Kevin Chan. All rights reserved.
//

import Foundation

struct APIResponse<T: Codable>: Codable {
    var data: T?

    enum CodingKeys: String, CodingKey {
        case data = "drinks"
    }
}
