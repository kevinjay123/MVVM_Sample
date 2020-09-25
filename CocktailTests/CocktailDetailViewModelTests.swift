//
//  CocktailDetailViewModelTests.swift
//  CocktailTests
//
//  Created by Kevin Chan on 2020/9/25.
//  Copyright © 2020 Kevin Chan. All rights reserved.
//

import Quick
import Nimble
import RxSwift

@testable import Cocktail

class CocktailDetailViewModelTests: QuickSpec {

    override func spec() {
        var viewModel: CocktailDetailViewModel!
        var disposeBag: DisposeBag!

        beforeEach {
            viewModel = CocktailDetailViewModel()
            disposeBag = DisposeBag()
        }

        afterEach {
            viewModel = nil
        }

        describe("Fetch cocktail's detail") {
            it("cocktail's detail") {
                let trigger = PublishSubject<Cocktail>()

                let cocktail = self.genCocktail()!
                let input = CocktailDetailViewModel.Input(trigger: trigger.mapToVoid(), cocktail: cocktail)
                let output = viewModel.transform(input: input)

                trigger.onNext(cocktail)

                waitUntil(timeout: 30) { (done) in
                    output.sectionModels
                        .subscribe(onNext: { detail in
                            if detail.count > 0 {
                                expect(detail.count).to(equal(1))
                                done()
                            }
                        })
                        .disposed(by: disposeBag)
                }
            }
        }
    }

    private func genCocktail() -> Cocktail? {
        let dataString = """
        {
            "drinks": [
                {
                    "idDrink": "17176",
                    "strDrink": "Ipamena",
                    "strCategory": "Ordinary Drink",
                    "strInstructions": "Cut half a lime into pieces, place in a shaker, add the sugar and crush. Measure the passion fruit juice, add it to the shaker and fill up with ice cubes. Close the shaker and shake vigorously. Pour the liquid into a glass, top up with ginger ale, stir with a teaspoon and then garnish the rim of the glass with a slice of lime",
                    "strDrinkThumb": "https://www.thecocktaildb.com/images/media/drink/yswuwp1469090992.jpg",
                }
            ]
        }
        """

        do {
            let data = Data(dataString.utf8)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(Drinks.self, from: data)

            return jsonData.cocktails.first

        } catch {
            NSLog("Can not load data string: %@", error.localizedDescription)
        }

        return nil
    }
}
