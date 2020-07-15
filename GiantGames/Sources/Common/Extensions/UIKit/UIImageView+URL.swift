//
//  UIImageView+URL.swift
//  GiantGames
//
//  Created by Xavier on 14/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

import UIKit
import Nuke

extension UIImageView {
    func load(url: URL, _ completion: ((UIImage?, ImagePipeline.Error?) -> Void)? = nil) {
        let options = ImageLoadingOptions(placeholder: #imageLiteral(resourceName: "placeholder"), failureImage: #imageLiteral(resourceName: "placeholder"))
        Nuke.loadImage(with: url, options: options, into: self) { result in
            switch result {
            case let .success(response): completion?(response.image, nil)
            case let .failure(error): completion?(nil, error)
            }
        }
    }
}
