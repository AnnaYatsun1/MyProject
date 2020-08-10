//
//  CommentsViewModel.swift
//  TestLightIT
//
//  Created by Анна Яцун on 05.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import Foundation


enum CommentsInputEvent: ViewControllerEventType {
    case reloadData
}

enum CommentsOutputEvents: ViewControllerEventType {
    case authError
}

class CommentsViewModel: RootViewModel<CommentsOutputEvents, CommentsInputEvent, CommentsConfigurator> {
    
    let dataSource: CommentsDataSource
    let product: CatalogModel
    let storageService: DataStorageService<RealmComments, [CommentsModel]>

    override init(
        configurator: CommentsConfigurator,
        eventEmiter: @escaping EventHandler<CommentsOutputEvents>
    ) {
        self.dataSource = configurator.dataSource
        self.product = configurator.product
        self.storageService = configurator.storageService

        super.init(configurator: configurator, eventEmiter: eventEmiter)
        
        self.product.id.do { id in
            self.isReachable
                ? self.getComments(id: id.description)
                : self.loadFromStorege(id: id.description)
        }
    }
    
    func getComments(id: String) {
        self.apiService.getComments(id: id) { [weak self] result in
            switch result {
            case let .success(models):
                 print(models)
                 self?.storageService.saveProductComments(items: models, product: id)
                 self?.dataSource.models = models
                 self?.internalEventEmiter?(.reloadData)
            case let .failure(error):
                debugPrint(error)
            }
        }
    }
    
    func createComments(commentModel: CommentModel, id: String) {
        if BaseConfigurations.default.token != nil {
            self.apiService.createComments(commentsModel: commentModel, productId: id) { [weak self] result in
                switch result {
                case let .success(models):
                    print(models)
                    self?.internalEventEmiter?(.reloadData)
                case let .failure(error):
                    debugPrint(error)
                }
            }
        } else {
            self.eventEmiter(.authError)
        }
    }
    
    private func loadFromStorege(id: String) {
        self.storageService.loadAlbums(id: id) { models in
            self.dataSource.setModels(models: models)
        }
    }
}
