//
//  GameCell.swift
//  GiantGames
//
//  Created by Xavier on 12/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

import UIKit

class GameCell: UITableViewCell {

    @IBOutlet private var nameLabel: UILabel!

    func setup(nameText: String) {
        nameLabel.text = nameText
    }
}
