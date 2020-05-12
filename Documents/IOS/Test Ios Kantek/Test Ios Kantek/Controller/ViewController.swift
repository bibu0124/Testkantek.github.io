//
//  ViewController.swift
//  Test Ios Kantek
//
//  Created by Macbook on 5/12/20.
//  Copyright © 2020 Macbook. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  @IBAction func loginButtonPressed(_ sender: Any) {
    
    AuthService.instance.login(emailTextField.text!, passwordTextField.text!) { (success, message) in
      if success{
        self.performSegue(withIdentifier: "indentifier", sender: self)
      }else{
        print("@@@@@@ message: ",message)
      }
    }
    
  
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
  }

  override func viewDidAppear(_ animated: Bool) {
    guard let accoutDecoded = defaults.object(forKey: "account") as? Data else {
      return
    }
    let account = NSKeyedUnarchiver.unarchiveObject(with: accoutDecoded) as? Account
    
    if (account?.accessToken != nil){
      self.performSegue(withIdentifier: "indentifier", sender: self)
    }else{
      
    }
  }

}

