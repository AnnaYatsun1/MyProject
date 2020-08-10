//
//  LogingViewModel.swift
//  TestLightIT
//
//  Created by Анна Яцун on 02.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import Foundation

enum LoginInputEvent: ViewControllerEventType {
    
}

enum LoginOutputEvent: ViewControllerEventType {
    case showCatalog
    case showRegister
    case noConnection
    case emptyFields
}

class LoginViewModel: RootViewModel<LoginOutputEvent, LoginInputEvent, LoginConfigurator> {
    
    override init(configurator: LoginConfigurator, eventEmiter: @escaping EventHandler<LoginOutputEvent>) {
        super.init(configurator: configurator, eventEmiter: eventEmiter)
    }
    
    func loginUser(userModel: UserModel) {
        if !self.isReachable {
            self.eventEmiter(.noConnection)
            
            return
        }
        
        self.apiService.loginOrRegister(userModel: userModel, isRegister: false) { result in
            switch result {
            case let .success(model):
                DispatchQueue.main.async {
                    model.token.do {
                        BaseConfigurations.default.token = $0
                    }
                    BaseConfigurations.default.user = UserDataModel(id: 1, username: userModel.username, first_name: nil, last_name: nil, email: nil, password: userModel.password)
                    
                    self.eventEmiter(.showCatalog)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
