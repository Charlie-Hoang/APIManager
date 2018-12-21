//
//  APIManager.swift
//  APIManagerExample
//
//  Created by Charlie on 12/21/18.
//  Copyright © 2018 Charlie. All rights reserved.
//

import Foundation
import Moya

typealias RESPONSE_SUCCESS = (Any?)-> Void
typealias RESPONSE_SUCCESS_DATA = (Data?)-> Void
typealias RESPONSE_FAILED = (String?)-> Void

// Common
class APIManager {
    static let shared = APIManager()
    func request(endpoint: Endpoint, success: @escaping RESPONSE_SUCCESS_DATA, failure: @escaping RESPONSE_FAILED){
        let provider = MoyaProvider<Endpoint>()
        provider.request(endpoint) { [unowned self] (result) in
            switch result{
            case .success(let response):
                print("request success!")
                self.validateResponse(responseData: response.data, success: { (res) in
                    success(res)
                }, failure: { (error) in
                    failure(error)
                })
            case .failure(let error):
                failure(error.localizedDescription)
                print("request failed! \(error.localizedDescription )")
            }
        }
    }
    func validateResponse(responseData: Data, success: @escaping RESPONSE_SUCCESS_DATA, failure: @escaping RESPONSE_FAILED) {
        let json =  try? JSONSerialization.jsonObject(with: responseData, options: .mutableLeaves) as! [String: Any]
        
        if let content = json?["result"] as? [String: Any]{
            if let code = content["code"] as? Int{
                if code == 0{
                    success(responseData)
                }else{
                    //TODO: handle error codes
                }
            }
        }else{
            let str = String(data: responseData, encoding: String.Encoding.utf8)
            failure("wrong response format!; \(str ?? "")")
        }
    }
}
//Main functions
extension APIManager{
    //MARK: LOGIN
    func doLogin(model: LoginRequestModel, success: @escaping RESPONSE_SUCCESS, failure: @escaping RESPONSE_FAILED) {
        request(endpoint: .login(model), success: { (responseData) in
            do {
                let res: DictResponseModel<DataResponseModel<LoginResponseModel>> = try JSONDecoder().decode(DictResponseModel<DataResponseModel<LoginResponseModel>>.self, from: responseData!)
                success(res.response?.data)
            } catch {
                failure("Could not parse JSON")
            }
        }) { (error) in
            failure(error)
        }
    }
    //MARK: GET TOKEN
    func getToken(model: TokenRequestModel, success: @escaping RESPONSE_SUCCESS, failure: @escaping RESPONSE_FAILED) {
        request(endpoint: .getToken(model), success: { (responseData) in
            do {
                let res: DictResponseModel<DataResponseModel<TokenResponseModel>> = try JSONDecoder().decode(DictResponseModel<DataResponseModel<TokenResponseModel>>.self, from: responseData!)
                success(res.response?.data)
            } catch {
                failure("Could not parse JSON")
            }
        }) { (error) in
            failure(error)
        }
    }
}
