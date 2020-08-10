//
//  RegisterViewController.swift
//  TestLightIT
//
//  Created by Анна Яцун on 02.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import UIKit

class RegisterViewController: RooViewController<RegisterInputEvent, RegisterOutputEvent, RegisterViewModel, RegisterConfigurator> {

    @IBOutlet var loginTextField: UITextField?
    @IBOutlet var passwordTextField: UITextField?
    @IBOutlet var confirmPasswordTextField: UITextField?
    @IBOutlet var registerButton: UIButton?
    @IBOutlet var registerContentView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func registerAction(_ sender: Any) {
        if !(self.loginTextField?.text?.isEmpty ?? true )
            && !(self.passwordTextField?.text?.isEmpty ?? true)
            && !(self.confirmPasswordTextField?.text?.isEmpty ?? true)
            && self.passwordTextField?.text == self.confirmPasswordTextField?.text {
            let userModel = UserModel(
                                      username: self.loginTextField?.text ?? "",
                                      password: self.passwordTextField?.text ?? "")
            self.viewModel.registerUser(userModel: userModel)
        } else {
            self.viewModel.eventEmiter(.emptyFeilds)
        }
    }
    
    override func configuration() {
        self.configure(view: self.registerButton, cornerRadius: 20, shadowOffset: CGSize(width: 10, height: 10), shadowColor: UIColor.black.cgColor, shadowOpacity: 0.23, shadowRadius: 6)
         self.configure(view: self.registerContentView, cornerRadius: 10, shadowOffset: CGSize(width: 10, height: 10), shadowColor: UIColor.black.cgColor, shadowOpacity: 0.23, shadowRadius: 6)
    }
}
