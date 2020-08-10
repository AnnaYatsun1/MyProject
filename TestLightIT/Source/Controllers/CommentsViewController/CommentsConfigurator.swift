//
//  CommentsConfigurator.swift
//  TestLightIT
//
//  Created by Анна Яцун on 05.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import Foundation
import RealmSwift

struct CommentsConfigurator: ConfiguratorType {
    
    var networkService: NetworkServiceType
    var apiService: APIServiceType
    let dataSource: CommentsDataSource
    let product: CatalogModel
    let storageService: DataStorageService<RealmComments, [CommentsModel]>

    init(networkService: NetworkServiceType,
         apiService: APIServiceType,
         dataSource: CommentsDataSource,
         product: CatalogModel,
         storageService: DataStorageService<RealmComments, [CommentsModel]>
    ) {
        self.networkService = networkService
        self.apiService = apiService
        self.dataSource = dataSource
        self.product = product
        self.storageService = storageService
    }
}
