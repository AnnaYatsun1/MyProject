//
//  CommentsDataSource.swift
//  TestLightIT
//
//  Created by Анна Яцун on 05.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import UIKit


enum CommentsDataSourceEvent: EventType {
}

class CommentsDataSource: RootTableDataSource<CommentsModel, CommentsDataSourceEvent> {
    
    // MARK:
    // MARK:  Overriden
    
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.reusableCell(ComentTableViewCell.self, for: indexPath) { catalogCell in
            let model = self.models[indexPath.row]
            catalogCell.fill(model: model)

        }
    }
}
