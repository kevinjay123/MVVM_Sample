//
//  CocktailDetailTableViewCellViewModel.swift
//  Cocktail
//
//  Created by Kevin Chan on 2020/8/27.
//  Copyright © 2020 Kevin Chan. All rights reserved.
//

import Foundation

class CocktailDetailTableViewCellViewModel {

    var name: String

    var category: String

    var imgUrl: URL?

    var instruction: String

    init(_ cocktail: Cocktail) {
        name = cocktail.name
        category = cocktail.category
        imgUrl = cocktail.imgUrl
        instruction = cocktail.instructions
    }
}
