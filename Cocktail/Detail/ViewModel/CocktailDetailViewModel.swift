//
//  CocktailDetailViewModel.swift
//  Cocktail
//
//  Created by Kevin Chan on 2020/8/27.
//  Copyright © 2020 Kevin Chan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class CocktailDetailViewModel: BaseViewModel, ViewModelType {
    
    struct Input {
        let trigger: Observable<Void>
        let cocktail: Cocktail
    }

    struct Output {
        let sectionModels: Observable<[CocktailDetailSectionModel]>
    }

    func transform(input: Input) -> Output {

        let sectionModels = BehaviorRelay<[CocktailDetailSectionModel]>(value: [])

        let triggered = input.trigger
        triggered.subscribe(onNext: { [weak self]() in
            guard let self = self else { return }

            Network.fetchDetail(by: input.cocktail.id)
                .trackActivity(self.loading)
                .trackError(self.error)
                .subscribe(onNext: { (drinks) in
                    if let cocktail = drinks.cocktails.first {
                        let dataSource: [CocktailDetailSectionModel] = [
                            CocktailDetailSectionModel(header: "detail", items: [CocktailDetailSectionItem(cocktail: cocktail)])
                        ]

                        sectionModels.accept(dataSource)
                    }
                })
                .disposed(by: self.rx.disposeBag)
        }).disposed(by: rx.disposeBag)

        return Output(sectionModels: sectionModels.asObservable())
    }
}
