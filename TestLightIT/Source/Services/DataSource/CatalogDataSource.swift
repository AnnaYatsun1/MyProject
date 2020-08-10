//
//  CatalogDataSource.swift
//  TestLightIT
//
//  Created by Анна Яцун on 05.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import UIKit


enum CatalogDataSourceEvent: EventType {
}

class CatalogDataSource: RootTableDataSource<CatalogModel, CatalogDataSourceEvent> {
    
    // MARK:
    // MARK:  Overriden
    
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.reusableCell(CatalogTableViewCell.self, for: indexPath) { catalogCell in
            let model = self.models[indexPath.row]
            catalogCell.fill(model: model)

        }
    }  
}
