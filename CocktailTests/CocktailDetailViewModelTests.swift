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
                    "strDrinkAlternate": null,
                    "strDrinkES": null,
                    "strDrinkDE": null,
                    "strDrinkFR": null,
                    "strDrinkZH-HANS": null,
                    "strDrinkZH-HANT": null,
                    "strTags": null,
                    "strVideo": null,
                    "strCategory": "Ordinary Drink",
                    "strIBA": null,
                    "strAlcoholic": "Non Alcoholic",
                    "strGlass": "Wine Glass",
                    "strInstructions": "Cut half a lime into pieces, place in a shaker, add the sugar and crush. Measure the passion fruit juice, add it to the shaker and fill up with ice cubes. Close the shaker and shake vigorously. Pour the liquid into a glass, top up with ginger ale, stir with a teaspoon and then garnish the rim of the glass with a slice of lime",
                    "strInstructionsES": null,
                    "strInstructionsDE": "Eine halbe Limette in Stücke schneiden, in einen Shaker geben, Zucker hinzufügen und zerdrücken. Passionsfruchtsaft abmessen, in den Shaker geben und mit Eiswürfeln auffüllen. Schließen Sie den Shaker und schütteln Sie ihn kräftig. Die Flüssigkeit in ein Glas gießen, mit Ginger Ale auffüllen, mit einem Teelöffel umrühren und dann den Rand des Glases mit einer Scheibe Limette garnieren.",
                    "strInstructionsFR": null,
                    "strInstructionsZH-HANS": null,
                    "strInstructionsZH-HANT": null,
                    "strDrinkThumb": "https://www.thecocktaildb.com/images/media/drink/yswuwp1469090992.jpg",
                    "strIngredient1": "Lime",
                    "strIngredient2": "Brown sugar",
                    "strIngredient3": "Passion fruit juice",
                    "strIngredient4": "Ginger ale",
                    "strIngredient5": "Ice",
                    "strIngredient6": null,
                    "strIngredient7": null,
                    "strIngredient8": null,
                    "strIngredient9": null,
                    "strIngredient10": null,
                    "strIngredient11": null,
                    "strIngredient12": null,
                    "strIngredient13": null,
                    "strIngredient14": null,
                    "strIngredient15": null,
                    "strMeasure1": "½",
                    "strMeasure2": "2 tsp",
                    "strMeasure3": "4 cl",
                    "strMeasure4": "top up with",
                    "strMeasure5": "fill",
                    "strMeasure6": null,
                    "strMeasure7": null,
                    "strMeasure8": null,
                    "strMeasure9": null,
                    "strMeasure10": null,
                    "strMeasure11": null,
                    "strMeasure12": null,
                    "strMeasure13": null,
                    "strMeasure14": null,
                    "strMeasure15": null,
                    "strCreativeCommonsConfirmed": "No",
                    "dateModified": "2016-07-21 09:49:52"
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
            NSLog("Can not load weather_town_list file: %@", error.localizedDescription)
        }

        return nil
    }
}
