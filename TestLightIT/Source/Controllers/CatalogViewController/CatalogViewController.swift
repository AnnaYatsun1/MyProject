//
//  CatalogViewController.swift
//  TestLightIT
//
//  Created by Анна Яцун on 02.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import UIKit

class CatalogViewController: RooViewController<CatalogOutputEvent, CatalogInputEvent, CatalogViewModel, CatalogConfigurator>, ReloadindDataType {
    @IBOutlet var catalogTableView: UITableView?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.catalogTableView?.register(CatalogTableViewCell.self)
        self.catalogTableView?.delegate = self
        self.catalogTableView?.dataSource = self.viewModel.catalogDataSource
        
        self.viewModel.internalEventEmiter = {[weak self]  result in
            switch result {
            case .reloadData:
                self?.reloadData(table: self?.catalogTableView)
            }
        }
    }
    
}

extension CatalogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.viewModel.catalogDataSource.models[indexPath.row]
        self.viewModel.eventEmiter(.moveTo(model))
    }
}
