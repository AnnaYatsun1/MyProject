//
//  RootTableDataSource.swift
//  TestLightIT
//
//  Created by Анна Яцун on 05.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import UIKit


protocol EventType {
  
}


class RootTableDataSource<Model, Event: EventType>: NSObject, UITableViewDataSource {
    
    // MARK: -
    // MARK: Variables
    
    let eventHandler: (Event) -> ()
    
    var models: [Model] = []
    
    // MARK:
    // MARK:  Initializator
    
    init(eventHandler: @escaping (Event) -> ()) {
        self.eventHandler = eventHandler
    }
    
    // MARK: -
    // MARK: LifeCyrcle
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.models.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.reusableCell(UITableViewCell.self, for: indexPath) { catalogCell in
        }
    }
    
    // MARK: -
    // MARK: Public
    
    func setModels(models: [Model]) {
           self.models = models
    }
}
