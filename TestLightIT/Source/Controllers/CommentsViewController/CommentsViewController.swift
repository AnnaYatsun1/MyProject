//
//  CommentsViewController.swift
//  TestLightIT
//
//  Created by Анна Яцун on 05.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import UIKit

class CommentsViewController: RooViewController<CommentsOutputEvents, CommentsInputEvent, CommentsViewModel, CommentsConfigurator>, ReloadindDataType {
    
    @IBOutlet var commentsTextField: UITextField?
    @IBOutlet var commentsTableView: UITableView?
    @IBOutlet var productImageView: UIImageView?
    @IBOutlet var productInfoLabel: UILabel?
    @IBOutlet var createCommentsButton: UIButton?
    
    @IBAction func publishCommentsActions(_ sender: Any) {
        let comentsModel = CommentModel(rate: 1, text: self.commentsTextField?.text ?? "")
        
        self.viewModel.product.id.do { id in
            self.viewModel.createComments(commentModel: comentsModel, id: id.description)
        }
        
        self.commentsTextField?.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.commentsTableView?.register(ComentTableViewCell.self)        
        self.commentsTableView?.dataSource = self.viewModel.dataSource
        
        self.viewModel.internalEventEmiter = { [weak self]  result in
            switch result {
            case .reloadData:
                self?.viewModel.product.id.do { id in
                    self?.viewModel.getComments(id: id.description)
                }
                self?.reloadData(table: self?.commentsTableView)
            }
        }
    }
    
    override func configuration() {
        self.configure(view: self.createCommentsButton, cornerRadius: 8, shadowOffset: CGSize(width: 10, height: 10), shadowColor: UIColor.black.cgColor, shadowOpacity: 0.23, shadowRadius: 6)
        
        let product = self.viewModel.product
        
        self.productInfoLabel?.text = product.title
        self.productImageView?.setImageFrom(urlString: Constant.imageUrl.rawValue + "\(product.img)" ?? "")
    }
}

