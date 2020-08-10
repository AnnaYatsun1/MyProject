//
//  ReloadindDataType.swift
//  TestLightIT
//
//  Created by Анна Яцун on 05.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import UIKit

protocol ReloadindDataType {
    func reloadData(table: UITableView?)
}

extension ReloadindDataType {
    func reloadData(table: UITableView?) {
        DispatchQueue.main.async {
            table?.reloadData()
        }
    }
}

