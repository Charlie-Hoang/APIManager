//
//  ResponseModel.swift
//  APIManagerExample
//
//  Created by Charlie on 12/21/18.
//  Copyright © 2018 Charlie. All rights reserved.
//

import Foundation

//MARK: Common
/**response format example
{
    "result": {
        "code": 0,
        "msg": ""
    },
    "response": {
        "data": []/{}
    }
}
 */
protocol ResponseModel: Codable {
    
}
struct ResultResponseModel: ResponseModel {
    var code: Int?
    var msg: String?
}
struct DictResponseModel<ResponseType: ResponseModel>: ResponseModel{
    var result: ResultResponseModel?
    var response: ResponseType?
}
struct ArrayResponseModel<ResponseType: ResponseModel>: ResponseModel {
    var result: ResultResponseModel?
    var response: [ResponseType]?
}
struct DataResponseModel<ResponseType: ResponseModel>: ResponseModel{
    var data: ResponseType?
}

//MARK: Login
/** response example
{
    "result": {
        "code": 0,
        "msg": ""
    },
    "response": {
        "data": {
            "userId": "12345",
            "userName": "charlie"
        }
    }
}
*/
struct LoginResponseModel: ResponseModel{
    var userId: String?
    var userName: String?
}

//MARK: Get Token
/** response example
{
    "result": {
        "code": 0,
        "msg": ""
    },
    "response": {
        "data": {
            "token": "123456789abcdefghijklmnopqrstuvwxwz",
            "expireDate": "2018-12-21"
        }
    }
}
*/
struct TokenResponseModel: ResponseModel{
    var token: String?
    var expireData: String?
}
