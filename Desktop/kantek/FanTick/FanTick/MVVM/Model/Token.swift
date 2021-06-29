//
//  Token.swift
//  Kiple
//
//  Created by ThanhPham on 8/3/17.
//  Copyright © 2017 com.futurify.vn. All rights reserved.
//

import Foundation


struct Token {
    
    fileprivate let userDefaults: UserDefaults
    
    var email: String? {
        get {
            return userDefaults.string(forKey: UserDefaultKey.kEmail.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultKey.kEmail.rawValue)
            userDefaults.synchronize()
        }
    }
    
    var password: String? {
        get {
            return userDefaults.string(forKey: UserDefaultKey.kPassword.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultKey.kPassword.rawValue)
            userDefaults.synchronize()
        }
    }
    
    var token: String? {
        get {
            return userDefaults.string(forKey: UserDefaultKey.kAccessToken.rawValue) ?? ""
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultKey.kAccessToken.rawValue)
            userDefaults.synchronize()
        }
    }
    
    var tokenExists: Bool {
        
        guard let token = self.token, token.count > 0 else {
            return false
        }
        return true
    }
    
    var user: UserModel? {
        get {
            guard let dict = userDefaults.dictionary(forKey: UserDefaultKey.kCurUser.rawValue), let user = dict.toCodableObject() as UserModel? else { return nil}
            return user
        }
        set {
//            userDefaults.set(newValue?.toDictionary() ?? [:], forKey: UserDefaultKey.kCurUser.rawValue)
            userDefaults.synchronize()
        }
    }
    
    var current_language: String? {
        get {
            return userDefaults.string(forKey: "UserDefaultKey.kLanguage.rawValue") ?? "vi"
        }
        set {
            userDefaults.set(newValue, forKey: "UserDefaultKey.kLanguage.rawValue")
            userDefaults.synchronize()
        }
    }
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    init() {
        self.userDefaults = UserDefaults.standard
    }
    
    func clear() {
        for key in UserDefaultKey.allCases {
            userDefaults.removeObject(forKey: key.rawValue)
            userDefaults.synchronize()
        }
        
    }
}

