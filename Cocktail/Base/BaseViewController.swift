//
//  BaseViewController.swift
//  Cocktail
//
//  Created by Kevin Chan on 2020/8/27.
//  Copyright © 2020 Kevin Chan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MBProgressHUD

class BaseViewController: UIViewController, Navigatable {

    var viewModel: BaseViewModel?
    var navigator: Navigator!

    var hud = MBProgressHUD()

    init(navigator: Navigator) {
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    let isLoading = BehaviorRelay(value: false)
    let error = PublishRelay<Error>()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        bindViewModel()
    }

    func setUI() {
        
    }

    func bindViewModel() {

    }
}

extension BaseViewController {
    func showHUD(text: String = "", mode: MBProgressHUDMode = .indeterminate) {
        DispatchQueue.main.async {
            self.hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            self.hud.mode = mode
            self.hud.label.text = text
        }
    }

    func dismissHUD(isAnimated: Bool) {
        DispatchQueue.main.async {
            self.hud.hide(animated: isAnimated)
        }
    }

    func dismissHUD(isAnimated: Bool, afterDelay: TimeInterval) {
        DispatchQueue.main.async {
            self.hud.hide(animated: isAnimated, afterDelay: afterDelay)
        }
    }
}

