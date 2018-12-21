//
//  ViewController.swift
//  APIManagerExample
//
//  Created by Charlie on 12/21/18.
//  Copyright © 2018 Charlie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        login()
    }

    func login(){
        var loginModel = LoginRequestModel()
        loginModel.userName = "abc@gmail.com"
        loginModel.passwd = "12345678"
        APIManager.shared.doLogin(model: loginModel, success: { (response) in
            if let res = response as? LoginResponseModel{
                //TODO:
                print(res)
            }
        }) { (errMsg) in
            print(errMsg!)
        }
    }
    func getToken(){
        var getTokenModel = TokenRequestModel()
        getTokenModel.userId = "001"
        APIManager.shared.getToken(model: getTokenModel, success: { (response) in
            if let res = response as? TokenResponseModel{
                //TODO:
                print(res)
            }
        }) { (errMsg) in
            print(errMsg!)
        }
    }
}

