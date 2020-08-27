//
//  Cocktail.swift
//  Cocktail
//
//  Created by Kevin Chan on 2020/8/27.
//  Copyright © 2020 Kevin Chan. All rights reserved.
//

import Foundation

struct Drinks: Codable {
    var cocktails: [Cocktail]

    private enum CodingKeys: String, CodingKey {
        case cocktails = "drinks"
    }
}

struct Cocktail: Codable {

    var id: String
    var name: String
    var category: String
    var instructions: String

    var imgUrl: URL? {
        return URL(string: imgUrlString)
    }

    private var imgUrlString: String

    private enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case category = "strCategory"
        case instructions = "strInstructions"
        case imgUrlString = "strDrinkThumb"
    }
}
