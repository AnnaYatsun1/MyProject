//
//  AppCoordinator.swift
//  TestLightIT
//
//  Created by Анна Яцун on 02.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import UIKit

enum AppCoordinatorEvent: CorrdinatorsEvent {
    
}

class AppCoordinator: RootCoordinator<AppCoordinatorEvent> {
    
    private weak var commentsViewController: CommentsViewController?
    private weak var catalogViewController: CatalogViewController?
    
    override func start() {
        self.createAutorizationController()
    }
    
    private func createAutorizationController() {
        let networkService = self.networkService
        let urlBilder = URLBuilder()
        let apiService = APIService(session: .shared, urlBuilder: urlBilder)
        let configurator = LoginConfigurator(networkService: networkService, apiService: apiService)
        let viewModel = LoginViewModel(configurator: configurator) { [weak self] in
            self?.autorizationHandle($0)
        }
        let controller = LoginViewController(viewModel: viewModel)
        controller.modalPresentationStyle = .fullScreen

        self.pushViewController(controller, animated: true)
    }
    
    private func autorizationHandle(_ event: LoginOutputEvent) {
        switch event {
        case .showCatalog:
            self.createCatalogViewController()
        case .showRegister:
            self.createRegisterViewController()
        case .noConnection:
            self.showAlert(title: "Error", message: "No Internet")
        case .emptyFields:
            self.showAlert(title: "Error", message: "Required fields is empty")
        }
    }
    
    private func createRegisterViewController() {
        let networkService = self.networkService
        let urlBilder = URLBuilder()
        let apiService = APIService(session: .shared, urlBuilder: urlBilder)
        let configurator = RegisterConfigurator(networkService: networkService, apiService: apiService)
        let viewModel = RegisterViewModel(configurator: configurator) { [weak self] in
            self?.registerHandle($0)
        }
        let controller = RegisterViewController(viewModel: viewModel)
        controller.modalPresentationStyle = .fullScreen
        
        self.topViewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func registerHandle(_ event: RegisterOutputEvent) {
        switch event {
        case .showLogin:
            self.createAutorizationController()
        case .emptyFeilds:
            self.showAlert(title: "Error", message: "Required fields is empty")
        case .noConnection:
            self.showAlert(title: "Error", message: "No Internet")
        }
    }
    
    private func createCatalogViewController() {
        let networkService = self.networkService
        let urlBilder = URLBuilder()
        let apiService = APIService(session: .shared, urlBuilder: urlBilder)
        let dataSource = CatalogDataSource() { [weak self]  in
            self?.catalogDataSourceHandle($0)
        }
        let storageService = DataStorageService(objectType: RealmObject<CatalogModel>.self)
        let configurator = CatalogConfigurator(networkService: networkService, apiService: apiService, catalogDataSource: dataSource, storegeService: storageService)
        let viewModel = CatalogViewModel(configurator: configurator) { [weak self] in
            self?.catalogHandle($0)
        }
        let controller = CatalogViewController(viewModel: viewModel)
        self.catalogViewController = controller
        controller.modalPresentationStyle = .fullScreen
        
        self.topViewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func catalogHandle(_ event: CatalogOutputEvent) {
        switch event {
        case let .moveTo(model):
            self.createCommentsViewController(product: model)
        }
    }
    
    private func catalogDataSourceHandle(_ event: CatalogDataSourceEvent) {
        switch event {
           
        }
    }
    
    private func createCommentsViewController(product: CatalogModel) {
        let networkService = self.networkService
        let urlBilder = URLBuilder()
        let apiService = APIService(session: .shared, urlBuilder: urlBilder)
        let dataSource = CommentsDataSource() { [weak self] in
            self?.commentsDataSourceHandle($0)
        }
        let storageService = DataStorageService(objectType: RealmComments.self)
        
        let configurator = CommentsConfigurator(networkService: networkService, apiService: apiService, dataSource: dataSource, product: product, storageService: storageService)
        let viewModel = CommentsViewModel(configurator: configurator) { [weak self] in
            self?.commentHandle($0)
        }

        let controller = CommentsViewController(viewModel: viewModel)
        self.catalogViewController?.present(controller, animated: true)
        
        self.commentsViewController = controller
        
    }
    
    private func commentHandle(_ event: CommentsOutputEvents) {
        switch event {
        case .authError:
            self.commentsViewController?.showAlert(title: "Sorry, you are not authorized")
        }
    }
    
    private func commentsDataSourceHandle(_ event: CommentsDataSourceEvent) {
        switch event {
    
        }
    }
}
