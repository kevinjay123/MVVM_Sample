//
//  BaseViewModel.swift
//  Cocktail
//
//  Created by Kevin Chan on 2020/8/27.
//  Copyright © 2020 Kevin Chan. All rights reserved.
//

import Foundation
import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}

class BaseViewModel: NSObject {
    
    let loading = ActivityIndicator()

    let error = ErrorTracker()
    let parsedError = PublishSubject<Error>()

    override init() {
        super.init()

        error.asObservable().map { (error) -> Error? in
            return error
        }.filterNil().bind(to: parsedError).disposed(by: rx.disposeBag)
    }
}
