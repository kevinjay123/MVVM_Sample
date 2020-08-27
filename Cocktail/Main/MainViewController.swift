//
//  MainViewController.swift
//  Cocktail
//
//  Created by Kevin Chan on 2020/8/26.
//  Copyright © 2020 Kevin Chan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MainViewController: BaseViewController {

    @IBOutlet weak var searchTextField: UITextField!

    @IBOutlet weak var clearTextButton: UIButton!

    @IBOutlet weak var resultTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        resultTableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
    }

    override func setUI() {
        super.setUI()
    }

    override func bindViewModel() {
        super.bindViewModel()

        navigator = Navigator.default
        viewModel = MainViewModel()

        guard let viewModel = viewModel as? MainViewModel else { return }

        viewModel.loading.asObservable().bind(to: self.isLoading).disposed(by: rx.disposeBag)
        viewModel.parsedError.asObservable().bind(to: self.error).disposed(by: rx.disposeBag)

        let _ = searchTextField.rx.textInput <-> viewModel.searchText

        let input = MainViewModel.Input(trigger: rx.viewWillAppear.mapToVoid())
        let output = viewModel.transform(input: input)

        output.buttonEnabled.bind(to: clearTextButton.rx.isEnabled).disposed(by: rx.disposeBag)
        output.sectionModels.bind(to: resultTableView.rx.items(dataSource: cocktailDataSource())).disposed(by: rx.disposeBag)

        Observable
            .zip(resultTableView.rx.itemSelected,
                 resultTableView.rx.modelSelected(MainSectionItem.self))
            .bind { [weak self](indexPath, model) in
                if let cocktail = model.cocktail {
                    self?.navigator.show(segue: .detail(cocktail: cocktail), sender: self, transition: .modal(isFullScreen: false))
                }
                self?.resultTableView.deselectRow(at: indexPath, animated: true)
            }
            .disposed(by: rx.disposeBag)

        clearTextButton.rx.tap
            .subscribe(onNext: { () in
                viewModel.searchText.accept("")
            })
            .disposed(by: rx.disposeBag)

        isLoading.asDriver().drive(onNext: { [weak self] (isLoading) in
            isLoading ? self?.showHUD() : self?.dismissHUD(isAnimated: false)
        }).disposed(by: rx.disposeBag)

        error.subscribe(onNext: { [weak self] error in
            self?.present(alert(error: error), animated: true, completion: nil)
        }).disposed(by: rx.disposeBag)
    }

    private func cocktailDataSource() -> RxTableViewSectionedAnimatedDataSource<MainSectionModel> {
        return RxTableViewSectionedAnimatedDataSource<MainSectionModel>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .fade, deleteAnimation: .fade),
            configureCell: { (dataSource, tableView, indexPath, model) -> UITableViewCell in

            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = model.cocktail?.name
            cell.detailTextLabel?.text = model.cocktail?.category

            return cell
        })
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

