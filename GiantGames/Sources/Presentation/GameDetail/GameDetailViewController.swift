//
//  GameDetailViewController.swift
//  GiantGames
//
//  Created by Xavier on 13/07/2020.
//  Copyright © 2020 GiantGames All rights reserved.
//

import UIKit

struct GameDetailViewData {
    let gameName: String
    let gameStoryline: String?
}

final class GameDetailViewController: UIViewController {
    var presenter: GameDetailPresenterProtocol!
    @IBOutlet private var coverImageView: UIImageView! {
        didSet {
            coverImageView.roundCorners(radius: 75.0)
        }
    }
    @IBOutlet private var ganeNameLabel: UILabel!
    @IBOutlet private var gameStorylineLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: - GameDetailViewProtocol

extension GameDetailViewController: GameDetailViewProtocol {
    func render(state: GameDetailViewState) {
        switch state {
        case let .showCover(url):
            showCover(url)
        case let .showView(data):
            showView(data)
        }
    }
}

// MARK: - Private

private extension GameDetailViewController {
    func showCover(_ url: URL) {
        coverImageView.load(url: url)
    }

    func showView(_ data: GameDetailViewData) {
        ganeNameLabel.text = data.gameName
        gameStorylineLabel.text = data.gameStoryline
    }
}
