//
//  CocktailDetailViewController.swift
//  Cocktail
//
//  Created by Kevin Chan on 2020/8/27.
//  Copyright © 2020 Kevin Chan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class CocktailDetailViewController: BaseViewController {

    @IBOutlet weak var detailTableView: UITableView!

    var cocktail: Cocktail!

    override func viewDidLoad() {
        super.viewDidLoad()

        detailTableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
    }

    override func setUI() {
        super.setUI()

        title = cocktail.category
    }

    override func bindViewModel() {
        super.bindViewModel()

        guard let viewModel = viewModel as? CocktailDetailViewModel else { return }

        viewModel.loading.asObservable().bind(to: self.isLoading).disposed(by: rx.disposeBag)
        viewModel.parsedError.asObservable().bind(to: self.error).disposed(by: rx.disposeBag)

        let input = CocktailDetailViewModel.Input(trigger: rx.viewWillAppear.mapToVoid(), cocktail: cocktail)
        let output = viewModel.transform(input: input)

        output.sectionModels.bind(to: detailTableView.rx.items(dataSource: detailDataSource())).disposed(by: rx.disposeBag)

        isLoading.asDriver().drive(onNext: { [weak self] (isLoading) in
            isLoading ? self?.showHUD() : self?.dismissHUD(isAnimated: false)
        }).disposed(by: rx.disposeBag)

        error.subscribe(onNext: { [weak self] error in
            self?.present(alert(error: error), animated: true, completion: nil)
        }).disposed(by: rx.disposeBag)
    }

    private func detailDataSource() -> RxTableViewSectionedAnimatedDataSource<CocktailDetailSectionModel> {
        return RxTableViewSectionedAnimatedDataSource<CocktailDetailSectionModel>(animationConfiguration: AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .fade, deleteAnimation: .fade), configureCell: { (dataSource, tableView, indexPath, model) -> UITableViewCell in

            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! CocktailDetailTableViewCell
            if let cocktail = model.cocktail {
                cell.bindViewModel(by: cocktail)
            }

            return cell
        })
    }
}

extension CocktailDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
