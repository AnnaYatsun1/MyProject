//
//  RegisterViewModel.swift
//  TestLightIT
//
//  Created by Анна Яцун on 02.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import Foundation


enum RegisterInputEvent: ViewControllerEventType {
    
}

enum RegisterOutputEvent: ViewControllerEventType {
    case showLogin
    case emptyFeilds
    case noConnection
}

class RegisterViewModel: RootViewModel<RegisterOutputEvent, RegisterInputEvent, RegisterConfigurator> {

    
    override init(configurator: RegisterConfigurator, eventEmiter: @escaping EventHandler<RegisterOutputEvent>) {
       
        super.init(configurator: configurator, eventEmiter: eventEmiter)
    }
    
    func registerUser(userModel: UserModel) {
        if !self.isReachable {
            self.eventEmiter(.noConnection)
            
            return
        }
        
        self.apiService.loginOrRegister(userModel: userModel, isRegister: true) {[weak self] result in
            switch result {
            case let .success(model):
                DispatchQueue.main.async {
                     self?.eventEmiter(.showLogin)
                }
                BaseConfigurations.default.token = model.token
                print(model)
            case let .failure(error):
                print(error)
            }
        }
    }
}
