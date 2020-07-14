//
//  HomeRouter.swift
//  GiantGames
//
//  Created by Xavier on 12/07/2020.
//  Copyright © 2020 GiantGames All rights reserved.
//

import UIKit

final class HomeRouter {
    private weak var viewController: UIViewController!
    private let container: DependencyInjectionApi
    
    init(viewController: UIViewController, container: DependencyInjectionApi) {
        self.viewController = viewController
        self.container = container
    }
}

extension HomeRouter: HomeRouterProtocol {
    func show(_ message: String, okTitle: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: okTitle, style: .default))
        viewController.present(alertController, animated: true)
    }

    func showGameDetail(_ game: Game) {
        let gameDetailViewController = GameDetailBuilder(container: container).buildModule(game)
        viewController.show(gameDetailViewController, sender: nil)
    }
}
