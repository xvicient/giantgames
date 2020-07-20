//
//  UIView+Gradient.swift
//  GiantGames
//
//  Created by Xavier on 20/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

import UIKit

public extension UIView {
    func addGradient(_ colors: [UIColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
