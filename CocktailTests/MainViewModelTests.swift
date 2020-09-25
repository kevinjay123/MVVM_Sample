//
//  MainViewModelTests.swift
//  CocktailTests
//
//  Created by Kevin Chan on 2020/9/25.
//  Copyright © 2020 Kevin Chan. All rights reserved.
//

import Quick
import Nimble
import RxSwift

@testable import Cocktail

class MainViewModelTests: QuickSpec {

    override func spec() {
        var viewModel: MainViewModel!
        var disposeBag: DisposeBag!

        beforeEach {
            viewModel = MainViewModel()
            disposeBag = DisposeBag()
        }

        afterEach {
            viewModel = nil
        }

        describe("Cocktail list from search text") {
            it("cocktails") {

                let input = MainViewModel.Input(trigger: viewModel.searchText.mapToVoid())
                let output = viewModel.transform(input: input)

                waitUntil(timeout: 30) { (done) in
                    output.buttonEnabled
                        .subscribe(onNext: { isEnabled in
                            expect(isEnabled).to(equal(false))
                        })
                        .disposed(by: disposeBag)

                    output.sectionModels
                        .subscribe(onNext: { sectionModels in
                            if sectionModels.count > 0 {
                                expect(sectionModels.count).to(equal(1))
                                done()
                            }
                        })
                        .disposed(by: disposeBag)
                }
            }
        }
    }
}
