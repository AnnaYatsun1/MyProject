//
//  ComentTableViewCell.swift
//  TestLightIT
//
//  Created by Анна Яцун on 05.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import UIKit

class ComentTableViewCell: UITableViewCell {

    @IBOutlet var logingLabel: UILabel?
    @IBOutlet var ratelabel: UILabel?
    @IBOutlet var commentsLabel: UILabel?
 
    
    func fill(model: CommentsModel) {
        self.logingLabel?.text = model.created_by?.username
        self.ratelabel?.text = model.rate.description
        self.commentsLabel?.text = model.text
    }
    
}
