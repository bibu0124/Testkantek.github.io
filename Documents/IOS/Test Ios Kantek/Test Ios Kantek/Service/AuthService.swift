//
//  AuthService.swift
//  Test Ios Kantek
//
//  Created by Macbook on 5/12/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

class AuthService{
  static let instance = AuthService()
  
  var account: Account?
  
  func login(_ email: String,_ password: String, completion: @escaping (Bool, String)-> Void ){
    
    let body: [String: Any] = [
      "email": email,
      "password": password,
    ]
    
    AF.request(URL_LOGIN(), method: .post, parameters: body).responseJSON { (response) in
      guard let resp = response.data else { return }
      guard let json = try? JSON(data: resp) else{fatalError("Error")}
      print(json)
      let success = json["result"].boolValue
      let message = json["message"].string
      print("@@@@@@@@",success)
      if success == false{
        completion(false, message!)
      }else{
        let id = json["data"]["id"].intValue
        let email = json["data"]["email"].stringValue
        let name = json["data"]["name"].string
        let phone = json["data"]["phone"].string
        let address = json["data"]["address"].string
        let latitude = json["data"]["latitude"].string
        let longitude = json["data"]["longitude"].string
        let birthday = json["data"]["birthday"].string
        
        let access_token = json["data"]["access_token"].string
        self.account = Account (id ?? -1, email ?? "", name ?? "", phone ?? "",address ?? "", latitude ?? "", longitude ?? "", birthday ?? "", access_token ?? "")
        
        defaults.set(NSKeyedArchiver.archivedData(withRootObject: self.account!), forKey: "account")
        defaults.synchronize()
      
        completion(true, message!)
      }
    }
  }
}
