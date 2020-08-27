//
//  Network.swift
//  Cocktail
//
//  Created by Kevin Chan on 2020/8/27.
//  Copyright © 2020 Kevin Chan. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa
import Moya
import RxMoya

struct Network {
    private static let disposeBag = DisposeBag()

    static private func request<Element: Codable>(by config: Config) -> Single<Element> {
        return Single.create { (single) -> Disposable in
            let provider = MoyaProvider<Config>()
            provider.request(config) { (result) in
                switch result {
                case .success(let response):
                    do {
                        let decoder = JSONDecoder()
                        let item = try decoder.decode(Element.self, from: response.data)
                        single(.success(item))
                    } catch {
                        single(.error(error))
                    }

                case .failure(let error):
                    single(.error(error))
                }
            }

            return Disposables.create()
        }
    }
}

extension Network {
    static func search(by keyword: String) -> Single<Drinks> {
        return request(by: Config.search(keyword: keyword))
    }

    static func fetchDetail(by id: String) -> Single<Drinks> {
        return request(by: Config.detail(id: id))
    }
}
