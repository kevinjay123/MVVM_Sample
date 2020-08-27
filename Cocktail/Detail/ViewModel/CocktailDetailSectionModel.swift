//
//  CocktailDetailSectionModel.swift
//  Cocktail
//
//  Created by Kevin Chan on 2020/8/27.
//  Copyright © 2020 Kevin Chan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

struct CocktailDetailSectionModel {
    var header: String
    var items: [Item]
}

extension CocktailDetailSectionModel: AnimatableSectionModelType {
    typealias Item = CocktailDetailSectionItem

    var identity: String {
        return header
    }
    init(original: CocktailDetailSectionModel, items: [Item]) {
        self = original
        self.items = items
    }
}

struct CocktailDetailSectionItem: IdentifiableType, Equatable {
    var identity: String {
        return self.cocktail?.id ?? ""
    }

    var cocktail: Cocktail?

    static func==(left: CocktailDetailSectionItem, right: CocktailDetailSectionItem) -> Bool {
        return left.cocktail?.id == right.cocktail?.id
    }
}
