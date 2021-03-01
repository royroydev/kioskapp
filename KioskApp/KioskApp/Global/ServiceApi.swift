//
//  ServiceApi.swift
//  KioskApp
//
//  Created by Neha Chaudhary on 09/10/20.
//  Copyright © 2020 Pankaj. All rights reserved.
//

import Foundation
import Alamofire
import JGProgressHUD


enum ApiCall {
    
    case checkInPwd
    case checkInQR
}


class ServiceApi {
    
    static func getApi(api : ApiCall) -> String {
        
        switch api {
        case .checkInPwd:
            return "check-in/password"
        default:
            return "check-in/qr-code"
        }
    }
    
    
    static func fetchGetRequest(call : ApiCall , prams : [String : Any],  completion: @escaping (String?, Bool?) -> Void) {
    
        
      var url = apiUrl
      url += getApi(api: call)
    
        // "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
        let headers : HTTPHeaders = [
            "api-version" : "1.0.0",
            "accept-lang" : "en"
        ]
        
        print(url)
        
        AF.request(url, method: .post, parameters: prams, headers: headers).responseString  { response in
            
            switch response.result {
            case .success(let value):
                print(value)
                let data = Data(value.utf8)
                do {
                     if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                           // try to read out a string array
                        completion(json["message"] as! String, json["status"] as! Bool)
                       }
                } catch let error as NSError {
                    print(error)
                }
                
            case .failure(let error):
                //SVProgressHUD.dismiss()
                print(error)
            }
        }

    }
}



