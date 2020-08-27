//
//  MainViewModel.swift
//  Cocktail
//
//  Created by Kevin Chan on 2020/8/27.
//  Copyright © 2020 Kevin Chan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel: BaseViewModel, ViewModelType {
    struct Input {
        let trigger: Observable<Void>
    }

    struct Output {
        let sectionModels: Observable<[MainSectionModel]>
        let buttonEnabled: Observable<Bool>
    }

    let searchText = BehaviorRelay(value: "")

    func transform(input: Input) -> Output {

        let sectionModels = BehaviorRelay<[MainSectionModel]>(value: [])
        let buttonEnabled = BehaviorRelay<Bool>(value: false)

        let triggered = input.trigger
        triggered
            .subscribe(onNext: { [weak self]() in
                guard let self = self else { return }

                self.searchText
                    .throttle(.milliseconds(3), scheduler: MainScheduler.instance)
                    .subscribe(onNext: { (text) in
                        buttonEnabled.accept(!text.isEmpty)

                        Network.search(by: text)
                            .trackActivity(self.loading)
                            .trackError(self.error)
                            .subscribe(onNext: { (drinks) in
                                let dataSource: [MainSectionModel] = [
                                    MainSectionModel(header: "cocktail", items: drinks.cocktails.compactMap { MainSectionItem(cocktail: $0) })
                                ]
                                sectionModels.accept(dataSource)
                            })
                            .disposed(by: self.rx.disposeBag)
                    })
                    .disposed(by: self.rx.disposeBag)
            })
            .disposed(by: rx.disposeBag)

        return Output(sectionModels: sectionModels.asObservable(),
                      buttonEnabled: buttonEnabled.asObservable())
    }
}
