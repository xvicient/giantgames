//
//  GameDetailMediaCollectionViewCell.swift
//  GiantGames
//
//  Created by Xavier on 14/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

import UIKit

class GameDetailMediaCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var mediaImageView: UIImageView! {
        didSet {
            mediaImageView.goFullScreenOnTap(true)
        }
    }

    func setup(_ url: URL) {
        mediaImageView.load(url: url)
    }
}
