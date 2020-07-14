//
//  GameDetailViewController.swift
//  GiantGames
//
//  Created by Xavier on 13/07/2020.
//  Copyright © 2020 GiantGames All rights reserved.
//

import UIKit

final class GameDetailViewController: UIViewController {
    var presenter: GameDetailPresenterProtocol!
    @IBOutlet private var coverImageView: UIImageView!

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
        }
    }
}

// MARK: - Private

private extension GameDetailViewController {
    func showCover(_ url: URL) {
        coverImageView.load(url: url)
    }
}
