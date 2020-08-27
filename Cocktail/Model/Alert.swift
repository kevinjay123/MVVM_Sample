//
//  Alert.swift
//  Cocktail
//
//  Created by Kevin Chan on 2020/8/27.
//  Copyright © 2020 Kevin Chan. All rights reserved.
//

import Foundation
import UIKit
import Moya

func alert(error: Error) -> UIAlertController {

    let nsError = error as NSError
    if nsError.domain == NSURLErrorDomain {
        return alert(error: nsError)
    }

    if let decodingError = error as? DecodingError {
        return alert(error: decodingError)
    }

    if let moyaError = error as? MoyaError {
        return alert(error: moyaError)
    }

    let controller = UIAlertController(title: NSLocalizedString("UI.Failed", comment: "Fail"), message: error.localizedDescription, preferredStyle: .alert)
    controller.addAction(UIAlertAction(title: NSLocalizedString("UI.OK", comment: "OK"), style: .cancel, handler: nil))

    return controller
}
