//
//  RootViewModel.swift
//  TestLightIT
//
//  Created by Анна Яцун on 02.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import UIKit




class RootViewModel<OutputEvents: ViewControllerEventType, InputEvents: ViewControllerEventType, Configurator: ConfiguratorType> {
    
    // MARK:
    // MARK:  Variables
    var networkService: NetworkServiceType
    let apiService: APIServiceType
    
    internal var internalEventEmiter: EventHandler<InputEvents>?
    public var eventEmiter: EventHandler<OutputEvents>
    var isReachable = true
    
    // MARK:
    // MARK:  Initializator

    
    public init(configurator: Configurator, eventEmiter: @escaping EventHandler<OutputEvents>) {
        self.networkService = configurator.networkService
        self.apiService = configurator.apiService
        self.eventEmiter = eventEmiter
        
        self.isReachable = self.networkService.isReachable
        self.networkService.isReachableDidChanged = { value in
            self.isReachable = value
        }
    }

}

