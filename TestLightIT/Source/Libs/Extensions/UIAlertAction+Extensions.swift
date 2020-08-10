//
//  UIAlertAction.swift
//  TestLightIT
//
//  Created by Анна Яцун on 07.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import  UIKit

extension UIAlertAction {

    static func `default`(_ title: String, handler: ((UIAlertAction) -> ())? = nil) -> UIAlertAction {
        return UIAlertAction(title: title, style: .default, handler: handler)
    }

    static func cancel(_ title: String, handler: ((UIAlertAction) -> ())? = nil) -> UIAlertAction {
        return UIAlertAction(title: title, style: .cancel, handler: handler)
    }
}
