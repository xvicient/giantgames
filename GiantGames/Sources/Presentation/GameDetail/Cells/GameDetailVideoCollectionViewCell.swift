//
//  GameDetailVideoCollectionViewCell.swift
//  GiantGames
//
//  Created by Xavier on 15/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

import UIKit
import WebKit

class GameDetailVideoCollectionViewCell: UICollectionViewCell {

    @IBOutlet private var videoWebView: WKWebView!

    func setup(_ url: URL) {
        videoWebView.configuration.allowsInlineMediaPlayback = true
        videoWebView.load(URLRequest(url: url))
    }
}
