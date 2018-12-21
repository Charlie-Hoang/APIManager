//
//  RequestModel.swift
//  APIManagerExample
//
//  Created by Charlie on 12/21/18.
//  Copyright © 2018 Charlie. All rights reserved.
//

import Foundation

protocol JSONable {
    func toDict() -> [String:Any]
}

extension JSONable {
    func toDict() -> [String:Any] {
        var dict = [String:Any]()
        let otherSelf = Mirror(reflecting: self)
        var superSelf = otherSelf.superclassMirror
        for child in otherSelf.children {
            if let key = child.label {
                dict[key] = child.value as! String
            }
        }
        while superSelf != nil {
            for child in superSelf!.children{
                if let key = child.label {
                    dict[key] = child.value as! String
                }
            }
            superSelf = superSelf?.superclassMirror
        }
        return dict
    }
}
protocol RequestModel: JSONable{
    
}
/*  Login Request Model
    request param example:
    userName="123@gmail.com"&password="123456"
*/

struct LoginRequestModel: RequestModel{
    var userName: String?
    var passwd: String?
}
/*  Get Token Request Model
 request param example:
 userId="123"
 */
struct TokenRequestModel: RequestModel{
    var userId: String?
}
