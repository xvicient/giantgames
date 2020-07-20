//
//  GameCell.swift
//  GiantGames
//
//  Created by Xavier on 12/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

import UIKit

class GameCell: UITableViewCell {
    @IBOutlet private var containerView: UIView! {
        didSet {
            containerView.addShadow(color: .darkGray)
        }
    }
    @IBOutlet weak var leftView: UIView! {
        didSet {
            leftView.roundCorners([.layerMinXMinYCorner, .layerMinXMaxYCorner], radius: 12.0)
        }
    }
    @IBOutlet weak var rightView: UIView! {
        didSet {
            rightView.roundCorners([.layerMaxXMinYCorner, .layerMaxXMaxYCorner], radius: 12.0)
        }
    }
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var summaryLabel: UILabel!
    @IBOutlet private var ratingTitleLabel: UILabel!
    @IBOutlet private var ratingLabel: UILabel!
    @IBOutlet private var releaseDateTitleLabel: UILabel!
    @IBOutlet private var releaseDate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func setup(_ item: HomeViewItem) {
        nameLabel.text = item.nameText
        summaryLabel.text = item.summaryText
        ratingTitleLabel.text = item.ratingTitle
        ratingLabel.text = item.ratingText
        releaseDateTitleLabel.text = item.releasedTitle
        releaseDate.text = item.releaseDate
    }
}
