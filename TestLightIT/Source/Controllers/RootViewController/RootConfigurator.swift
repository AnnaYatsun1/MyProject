//
//  RootConfigurator.swift
//  TestLightIT
//
//  Created by Анна Яцун on 02.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import Foundation

protocol ConfiguratorType  {
    var networkService: NetworkServiceType { get set }
    var apiService: APIServiceType { get set }
}

