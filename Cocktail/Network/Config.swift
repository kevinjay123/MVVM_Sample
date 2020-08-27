//
//  Config.swift
//  Cocktail
//
//  Created by Kevin Chan on 2020/8/27.
//  Copyright © 2020 Kevin Chan. All rights reserved.
//

import Foundation
import Moya

enum Config {
    case search(keyword: String)
}

extension Config: TargetType {
    var baseURL: URL {
        return URL(string: "https://www.thecocktaildb.com/api/json/v1/1")!
    }
    
    var headers: [String : String]? {
        return ["Content-type" : "application/json"]
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var path: String {
        switch self {
        case .search:
            return "/search.php"
        }
    }
    
    var parameters: [String: Any]? {
        var params: [String : Any] = [:]

        switch self {
        case .search(let keyword):
            params["s"] = keyword
            return params
        }
    }
        
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters ?? [:], encoding: URLEncoding.default)
    }
}
