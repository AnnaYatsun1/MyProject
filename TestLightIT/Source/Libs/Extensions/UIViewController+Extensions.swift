//
//  File.swift
//  TestLightIT
//
//  Created by Анна Яцун on 07.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import UIKit

extension UIViewController {

    func showAlert(title: String?,
                   message: String? = nil,
                   preferredStyle: UIAlertController.Style = .alert,
                   actions: [UIAlertAction]? = [UIAlertAction(title: "Close", style: .destructive, handler: nil)]) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: preferredStyle)
        actions?.forEach { alertController.addAction($0) }
        self.present(alertController, animated: true, completion: nil)
    }
}
