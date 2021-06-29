//
//  AuthenViewModel.swift
//  SnapChat
//
//  Created by admin on 5/5/20.
//  Copyright © 2020 ThanhPham. All rights reserved.
//

import UIKit

class AuthenViewModel: NSObject {
    
    func login(parameters : [String : Any]?, _ completeHandler:@escaping (_ success: Bool,_ data: UserModel?, _ message : String) ->()) {
        APIServices.shared.login(parameters: parameters) { (data) in
            guard let user = data?.data, let token = user.token else{
                completeHandler(false, nil, data?.message ?? "Error")
                return
            }
            var tokenSave = Token()
            tokenSave.user = user
            if let pass = parameters!["password"] as? String {
                tokenSave.password = pass
            }
            tokenSave.email = user.user?.email ?? ""
            tokenSave.token = token
            if data?.result == true {
                completeHandler(true, user, data?.message ?? "")
            }else {
                completeHandler(false,nil, data?.message ?? "")
            }
        }
    }
    
    

}
