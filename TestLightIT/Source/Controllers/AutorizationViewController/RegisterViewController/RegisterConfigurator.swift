//
//  RegisterConfigurator.swift
//  TestLightIT
//
//  Created by Анна Яцун on 02.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import Foundation

struct RegisterConfigurator: ConfiguratorType {
    
    var networkService: NetworkServiceType
    var apiService: APIServiceType

    
    init(networkService: NetworkServiceType, apiService: APIServiceType) {
        self.networkService = networkService
        self.apiService = apiService
    }
}

