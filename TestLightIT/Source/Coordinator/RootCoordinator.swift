//
//  RootCoordinator.swift
//  TestLightIT
//
//  Created by Анна Яцун on 02.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import UIKit
import Reachability

protocol CorrdinatorsEvent {
    
}

class RootCoordinator<Event: CorrdinatorsEvent>: UINavigationController {
    
    var isReachable = true
    var networkService: NetworkServiceType
        
    // MARK:
    // MARK:  Initializator
    
    init(isHiddenNavigationBar: Bool, networkService: NetworkService) {
        self.networkService = networkService
        
        super.init(nibName: nil, bundle: nil)
        self.isNavigationBarHidden = isHiddenNavigationBar
        self.start()
        
        self.isReachable = self.networkService.isReachable
        self.networkService.isReachableDidChanged = { value in
            self.isReachable = value
            
            if !value {
                self.showAlert(title: "Error", message: "No Internet")
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:
    // MARK:  Overrided
    
    func start() {
        
    }
    
    func showAlert(title: String?, message: String, handler: (() -> ())? = nil ) {
        let okAction = UIAlertAction.cancel("OK") { _ in  }
        
        self.topViewController?.showAlert(title: title,
                                          message: message,
                                          actions: [okAction])
    }
}
