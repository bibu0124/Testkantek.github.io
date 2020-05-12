//
//  Acount.swift
//  Test Ios Kantek
//
//  Created by Macbook on 5/12/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import Foundation
class Account: NSObject, NSCoding{
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(id, forKey:"id")
    aCoder.encode(email, forKey:"email")
    aCoder.encode(name, forKey:"name")
    aCoder.encode(phone, forKey:"phone")
    aCoder.encode(address, forKey:"address")
    aCoder.encode(latitude, forKey:"latitude")
    aCoder.encode(longtitude, forKey:"longtitude")
    aCoder.encode(birthday, forKey:"birthday")
    aCoder.encode(accessToken, forKey:"accessToken")
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    let id = aDecoder.decodeObject(forKey: "id") as? Int
    let email = aDecoder.decodeObject(forKey: "email") as? String
    let name = aDecoder.decodeObject(forKey: "name") as? String
    let phone = aDecoder.decodeObject(forKey: "phone") as? String
    let address = aDecoder.decodeObject(forKey: "address") as? String
    let latitude = aDecoder.decodeObject(forKey: "latitude") as? String
    let longtitude = aDecoder.decodeObject(forKey: "longtitude") as? String
    let birthday = aDecoder.decodeObject(forKey: "birthday") as? String
    let accessToken = aDecoder.decodeObject(forKey: "accessToken") as? String
  
    self.init(id ?? -1, email!, name!, phone!, address!, latitude!, longtitude!, birthday!, accessToken!)
  }
  
  var id: Int = 0
  var email: String = ""
  var name: String = ""
  var phone: String = ""
  var address: String = ""
  var latitude: String = ""
  var longtitude: String = ""
  var birthday: String = ""
  var accessToken: String = ""
  
  init(_ id: Int,_ email: String,_ name: String,_ phone: String ,_ address: String,_ latitude: String,_ longtitude: String,_ birthday: String,_ accessToken: String){
    self.id = id
    self.name = name
    self.address = address
    self.phone = phone
    self.address = address
    self.latitude = latitude
    self.longtitude = longtitude
    self.birthday = birthday
    self.accessToken = accessToken
  }
  
  
}
