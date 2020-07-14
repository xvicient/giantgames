//
//  UIView+RoundCorners.swift
//  GiantGames
//
//  Created by Xavier on 14/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

import UIKit

public extension UIView {
    func roundCorners(_ corners: CACornerMask = [.layerMinXMinYCorner,
                                                 .layerMaxXMinYCorner,
                                                 .layerMinXMaxYCorner,
                                                 .layerMaxXMaxYCorner],
                      radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = corners
    }
}
