//
//  CatalogTableViewCell.swift
//  TestLightIT
//
//  Created by Анна Яцун on 05.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import UIKit

enum Constant: String {
    case imageUrl = "http://smktesting.herokuapp.com/static/"
}

class CatalogTableViewCell: UITableViewCell {
    
    enum CatalogViewCellEvent {
        
    }
    
    @IBOutlet var catalogImageView: UIImageView?
    @IBOutlet var catalogTitleLabel: UILabel?
    @IBOutlet var catalogTextLabel: UILabel?
    
    //   var eventhandlerOutputEvents: ((CatalogViewCellEvent) -> ())?
    
    
    func fill(model: CatalogModel) {
        self.catalogTitleLabel?.text = model.title
        self.catalogTextLabel?.text = model.text
        self.catalogImageView?.setImageFrom(urlString: Constant.imageUrl.rawValue + "\(model.img)" ?? "")
    }
}

