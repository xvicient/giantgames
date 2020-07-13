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

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension GameDetailViewController: GameDetailViewProtocol {
    func render(state: GameDetailViewState) {}
}
