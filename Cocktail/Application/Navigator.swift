//
//  Navigator.swift
//  Cocktail
//
//  Created by Kevin Chan on 2020/8/27.
//  Copyright © 2020 Kevin Chan. All rights reserved.
//

import Foundation
import UIKit

protocol Navigatable {
    var navigator: Navigator! { get set }
}

enum Scene: Hashable {

    // Main
    case main

    // Detail
    case detail(cocktail: Cocktail)

    var viewModel: BaseViewModel {
        switch self {
        case .detail:
            return CocktailDetailViewModel()

        default:
            return BaseViewModel()
        }
    }

    var storyboardName: String {
        switch self {
        case .detail:
            return "Detail"
        default:
            return ""
        }

    }

    var storyboardId: String {
        switch self {
        case .detail:
            return "CocktailDetailViewController"
        default:
            return ""
        }
    }
}


class Navigator {
    static var `default` = Navigator()

    enum Transition {
        case root(in: UIWindow)
        case navigation
        case modal(isFullScreen: Bool = true)
        case detail
        case alert
        case custom
    }

    private func get(segue: Scene) -> UIViewController? {

        switch segue {
        case .detail(let cocktail):
            if let vc = UIStoryboard(name: segue.storyboardName, bundle: nil).instantiateViewController(withIdentifier: segue.storyboardId) as? CocktailDetailViewController {
                vc.navigator = self
                vc.viewModel = segue.viewModel
                vc.cocktail = cocktail

                return vc
            }

        default:
            return nil
        }

        return nil
    }

    func pop(sender: UIViewController?, toRoot: Bool = false) {
        if toRoot {
            sender?.navigationController?.popToRootViewController(animated: true)
        } else {
            sender?.navigationController?.popViewController(animated: true)
        }
    }

    func dismiss(sender: UIViewController?) {
        sender?.navigationController?.dismiss(animated: true, completion: nil)
    }

    func show(segue: Scene, sender: UIViewController?, transition: Transition = .navigation) {
        if let vc = get(segue: segue) {
            show(target: vc, sender: sender, transition: transition)
        }
    }

    private func show(target: UIViewController, sender: UIViewController?, transition: Transition) {

        switch transition {
        case .root(in: let window):
            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                window.rootViewController = target
            }, completion: nil)
            return
        default:
            break
        }

        guard let sender = sender else {
            fatalError("You need to pass in a sender for .navigation or .modal transitions")
        }

        switch transition {
        case .navigation:
            if let nav = sender.navigationController {
                // push controller to navigation stack
                nav.pushViewController(target, animated: true)
            }
        case .modal(let isFullScreen):
            // present modally
            DispatchQueue.main.async {
                let nav = BaseNavigationController(rootViewController: target)
                nav.modalPresentationStyle = isFullScreen ? .fullScreen : .popover

                sender.present(nav, animated: true, completion: nil)
            }

        case .detail:
            DispatchQueue.main.async {
                let nav = BaseNavigationController(rootViewController: target)
                sender.showDetailViewController(nav, sender: nil)
            }
        default:
            break
        }

    }
}

