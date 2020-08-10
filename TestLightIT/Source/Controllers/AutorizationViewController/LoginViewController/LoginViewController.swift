//
//  LoginViewController.swift
//  TestLightIT
//
//  Created by Анна Яцун on 02.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import UIKit

class LoginViewController: RooViewController<LoginInputEvent, LoginOutputEvent, LoginViewModel, LoginConfigurator> {

    @IBOutlet var loginTextField: UITextField?
    @IBOutlet var passwordTextField: UITextField?
    @IBOutlet var registerButton: UIButton?
    @IBOutlet var loginButton: UIButton?
    @IBOutlet var logingContentView: UIView?
    
    @IBOutlet var showLisfOfProduct: UIButton?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func showListAction(_ sender: Any) {
        self.viewModel.eventEmiter(.showCatalog)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        if !(self.loginTextField?.text?.isEmpty ?? true ) && !(self.passwordTextField?.text?.isEmpty ?? true) {
            let user = UserModel(username: self.loginTextField?.text ?? "", password: self.passwordTextField?.text ?? "")
            
            self.viewModel.loginUser(userModel: user)
        } else {
            self.viewModel.eventEmiter(.emptyFields)
        }
    }
    
    
    @IBAction func showRegisterController(_ sender: Any) {
        self.viewModel.eventEmiter(.showRegister)
    }
    
    override func configuration() {
        self.configurator(to: self.registerButton)
        self.configurator(to: self.loginButton)
        self.configurator(to: self.showLisfOfProduct)
        self.configure(view: self.logingContentView, cornerRadius: 10, shadowOffset: CGSize(width: 10, height: 10), shadowColor: UIColor.black.cgColor, shadowOpacity: 0.23, shadowRadius: 6)
    }
    
    private func configurator(to view: UIView?) {
        self.configure(view: view, cornerRadius: 20, shadowOffset: CGSize(width: 10, height: 10), shadowColor: UIColor.black.cgColor, shadowOpacity: 0.23, shadowRadius: 6)
    }
}
