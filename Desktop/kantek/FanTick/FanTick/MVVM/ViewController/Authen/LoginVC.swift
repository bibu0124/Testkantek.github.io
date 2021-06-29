//
//  LoginViewController.swift
//  Knowitall
//
//  Created by thanhnguyen on 4/8/20.
//  Copyright © 2020 ThanhPham. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import FirebaseMessaging
class LoginVC: BaseHiddenNavigationController {
    //MARK: IBOUTLETS
    @IBOutlet var tfPassword: UITextField!
    @IBOutlet var tfEmail: UITextField!
    
    
    //MARK: OTHER VARIABLES
    var viewModel = AuthenViewModel()
    //MARK: VIEW LIFE CYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupVar()
        setupUI()
        callAPI()
    }
    
    //MARK: - SETUP UI & VAR
    func setupVar() {
    }
    
    func setupUI() {
    }
    
    //MARK - CALL API
    func callAPI() {
        
        fillData()
    }
    
    //MARK: - FILL DATA
    func fillData() {
//        tfEmail.text = "testaccount123@yopmail.com"
//        tfPassword.text = "123456"
        
    }
    
    
    //MARK: - BUTTON ACTIONS
    
    @IBAction func forgotPassword(_ sender: Any) {
    }
    @IBAction func loginAction(_ sender: Any){
        //        Utils.shared.gotoHome()
        //        return
        
        self.view.endEditing(true)
        
        guard let email = tfEmail.text, email.count > 0 else {
            self.showAlert(title: kMsgInvalidEmail, message: nil) {
                self.tfEmail.becomeFirstResponder()
            }
            return
        }
        guard let pass = tfPassword.text, pass.count > 5 else {
            self.showAlert(title: kValidatorPasswordInvalid, message: nil) {
                self.tfEmail.becomeFirstResponder()
            }
            return
        }
        SHARE_APPLICATION_DELEGATE.login(email, password: pass) { (success, model, mgs) in
            if success {
                self.showAlert(title: "", message: mgs) {
                    Utils.shared.gotoHome()
                }
            }else {
                HelperAlert.showAlertWithMessage(mgs)
                
            }
        }
    }
    
    @IBAction func showPassLogin(_ sender: UIButton) {
        self.tfPassword.isSecureTextEntry = !self.tfPassword.isSecureTextEntry
        sender.setTitle(self.tfPassword.isSecureTextEntry == true ? "Show" : "Hidden", for: .normal)
    }
    
    
}

