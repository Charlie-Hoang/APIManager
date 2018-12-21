//
//  CHEndpoind.swift
//  APIManagerExample
//
//  Created by Charlie on 12/21/18.
//  Copyright © 2018 Charlie. All rights reserved.
//

import Foundation
import Moya

enum Endpoint{
    case login(_ model: RequestModel)
    case getToken(_ model: RequestModel)
    case unidentified
}
extension Endpoint: TargetType{
    
    var baseURL: URL {
        switch self {
        case .login, .getToken:
            return URL(string: "https://example.com/project")!
        default:
            return URL(string:"")!
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/user/login"
        case .getToken:
            return "/user/token"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login,
             .getToken:
            return .post
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .login:
            return "".data(using: .utf8)!
        default:
            return Data()
        }
    }
    
    var task: Task {
        switch self {
        case .login(let model),
             .getToken(let model):
            return .requestParameters(parameters: model.toDict(), encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    var headers: [String : String]? {
//        return ["Content-type": "application/json"]
        return ["Content-type": "application/x-www-form-urlencoded"]
//        return ["Content-type": "application/form-data"]
    }
}
