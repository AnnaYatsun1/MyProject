//
//  ConfigureType.swift
//  TestLightIT
//
//  Created by Анна Яцун on 07.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import UIKit

protocol ConfigureType {
    func configure(
        view: UIView?,
        color: CGColor?,
        cornerRadius: CGFloat?,
        borderWidth: CGFloat?,
        shadowOffset: CGSize?,
        shadowColor: CGColor?,
        shadowOpacity: Float?,
        shadowRadius: CGFloat?
    )
    
    func clear(view: UIView)
}

extension ConfigureType {
    func configure(
        view: UIView?,
        color: CGColor? = nil,
        cornerRadius: CGFloat? = nil,
        borderWidth: CGFloat? = nil,
        shadowOffset: CGSize? = nil,
        shadowColor: CGColor? = nil,
        shadowOpacity: Float? = nil,
        shadowRadius: CGFloat? = nil
    ) {
        view?.layer.shadowOffset = shadowOffset ?? .zero
        view?.layer.shadowOpacity = shadowOpacity ?? 0
        view?.layer.shadowRadius = shadowRadius ?? 0
        view?.layer.shadowColor = shadowColor
        view?.layer.borderWidth = borderWidth ?? 0
        view?.layer.borderColor = color
        view?.layer.cornerRadius = cornerRadius ?? 0
    }
    
    func clear(view: UIView) {
        view.layer.borderWidth = 0
        view.layer.borderColor = nil
        view.layer.cornerRadius = 0
    }
}
