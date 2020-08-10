//
//  CatalogViewModel.swift
//  TestLightIT
//
//  Created by Анна Яцун on 02.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import Foundation

enum CatalogInputEvent: ViewControllerEventType {
    case reloadData
}

enum CatalogOutputEvent: ViewControllerEventType {
    case moveTo(CatalogModel)
}

class CatalogViewModel: RootViewModel<CatalogOutputEvent, CatalogInputEvent, CatalogConfigurator> {

    let catalogDataSource: CatalogDataSource
    let storegeService: DataStorageService<RealmObject<CatalogModel>, CatalogModel>

    override init(
        configurator: CatalogConfigurator,
        eventEmiter: @escaping EventHandler<CatalogOutputEvent>
    ) {
        self.catalogDataSource = configurator.catalogDataSource
        self.storegeService = configurator.storegeService
        super.init(configurator: configurator, eventEmiter: eventEmiter)
        
        self.isReachable
            ? self.getCatelog()
            : self.loadFromStorege()       
    }
    
    func getCatelog() {
        self.apiService.getCatalog() { [weak self] result in
            switch result {
            case let .success(models):
                self?.catalogDataSource.models = models
                self?.storegeService.deleteItems()
                self?.storegeService.saveItems(models)
                self?.internalEventEmiter?(.reloadData)
            case let .failure(error):
                debugPrint(error)
            }
        }
    }
    
    func loadFromStorege() {
        self.storegeService.loadItems { [weak self] product in
            self?.catalogDataSource.setModels(models: product)
            self?.internalEventEmiter?(.reloadData)
        }
    }
}
