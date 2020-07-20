//
//  UIView+Shadow.swift
//  GiantGames
//
//  Created by Xavier on 20/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

import UIKit

extension UIView {
    func addShadow(radius: CGFloat = 4,
                   opacity: Float = 0.2,
                   color: UIColor = .black,
                   offset: CGSize = CGSize(width: 0, height: 2)) {
        layer.masksToBounds = false
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
    }
}
