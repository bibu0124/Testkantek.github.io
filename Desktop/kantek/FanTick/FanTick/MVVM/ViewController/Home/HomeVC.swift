//
//  HomeVC.swift
//  SnapChat
//
//  Created by admin on 5/5/20.
//  Copyright © 2020 ThanhPham. All rights reserved.
//

import UIKit

class HomeVC: BaseHiddenNavigationController {
    //MARK: IBOUTLETS
    
    
    //MARK: OTHER VARIABLES
    
    
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
        
    }
    
    //MARK: - FILL DATA
    func fillData() {
        
    }
    
    //MARK: - BUTTON ACTIONS
    
}


