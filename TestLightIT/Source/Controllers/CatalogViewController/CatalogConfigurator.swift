//
//  CatalogConfigurator.swift
//  TestLightIT
//
//  Created by Анна Яцун on 02.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import Foundation

struct CatalogConfigurator: ConfiguratorType {
    
    var networkService: NetworkServiceType
    var apiService: APIServiceType
    var catalogDataSource: CatalogDataSource
    let storegeService: DataStorageService<RealmObject<CatalogModel>, CatalogModel>

    
    init(networkService: NetworkServiceType,
         apiService: APIServiceType,
         catalogDataSource: CatalogDataSource,
         storegeService: DataStorageService<RealmObject<CatalogModel>, CatalogModel>
    ) {
        self.networkService = networkService
        self.apiService = apiService
        self.catalogDataSource = catalogDataSource
        self.storegeService = storegeService
    }
}
