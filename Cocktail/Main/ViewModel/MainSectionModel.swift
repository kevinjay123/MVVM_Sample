//
//  MainSectionModel.swift
//  Cocktail
//
//  Created by Kevin Chan on 2020/8/27.
//  Copyright © 2020 Kevin Chan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

struct MainSectionModel {
    var header: String
    var items: [Item]
}

extension MainSectionModel: AnimatableSectionModelType {
    typealias Item = MainSectionItem

    var identity: String {
        return header
    }
    init(original: MainSectionModel, items: [Item]) {
        self = original
        self.items = items
    }
}

struct MainSectionItem: IdentifiableType, Equatable {
    var identity: String {
        return self.cocktail?.id ?? ""
    }

    var cocktail: Cocktail?

    static func==(left: MainSectionItem, right: MainSectionItem) -> Bool {
        return left.cocktail?.id == right.cocktail?.id
    }
}
