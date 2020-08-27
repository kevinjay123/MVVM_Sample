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

class MainViewController: BaseViewController {

    @IBOutlet weak var searchTextField: UITextField!

    @IBOutlet weak var clearTextButton: UIButton!

    @IBOutlet weak var resultTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func setUI() {
        super.setUI()
    }

    override func bindViewModel() {
        super.bindViewModel()

        viewModel = MainViewModel()

        guard let viewModel = viewModel as? MainViewModel else { return }

        viewModel.loading.asObservable().bind(to: self.isLoading).disposed(by: rx.disposeBag)
        viewModel.parsedError.asObservable().bind(to: self.error).disposed(by: rx.disposeBag)

        let input = MainViewModel.Input(trigger: rx.viewWillAppear.mapToVoid())
        let output = viewModel.transform(input: input)

        let _ = searchTextField.rx.textInput <-> viewModel.searchText

        isLoading.asDriver().drive(onNext: { [weak self] (isLoading) in
            isLoading ? self?.showHUD() : self?.dismissHUD(isAnimated: false)
        }).disposed(by: rx.disposeBag)

        error.subscribe(onNext: { [weak self] error in
            self?.present(alert(error: error), animated: true, completion: nil)
        }).disposed(by: rx.disposeBag)
    }
}

