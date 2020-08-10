//
//  UITableView.swift
//  TestLightIT
//
//  Created by Анна Яцун on 05.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import UIKit

extension UITableView {
    func register(_ nameClass: AnyClass) {
        self.register(UINib(nameClass), forCellReuseIdentifier: toString(nameClass))
    }
    
    func dequeueReusableCell(withCellClass cellClass: AnyClass) -> UITableViewCell? {
        return self.dequeueReusableCell(withIdentifier: toString(cellClass))
    }

    func dequeueReusableCell(withCellClass cellClass: AnyClass, for indexPath: IndexPath) -> UITableViewCell {
       return self.dequeueReusableCell(withIdentifier: toString(cellClass), for: indexPath)
    }
    
    func reusableCell<Result: UITableViewCell>(
        _ type: Result.Type,
        for indexPath: IndexPath,
        configure: (Result) -> ()
        )
        -> UITableViewCell
    {
        let identifier = String(describing: type)
        
        let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cast(cell).do(configure)
        
        return cell
    }

}
