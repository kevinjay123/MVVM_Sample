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
        
    }

    let searchText = BehaviorRelay(value: "")

    func transform(input: Input) -> Output {
        return Output()
    }
}
