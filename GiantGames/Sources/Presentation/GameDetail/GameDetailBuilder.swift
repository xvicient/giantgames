//
//  GameDetailBuilder.swift
//  GiantGames
//
//  Created by Xavier on 13/07/2020.
//  Copyright © 2020 GiantGames All rights reserved.
//

import UIKit

final class GameDetailBuilder {
    private let container: DependencyInjectionApi

    init(container: DependencyInjectionApi) {
        self.container = container
    }
}

extension GameDetailBuilder: GameDetailBuilderProtocol {
    func buildModule(_ game: Game) -> UIViewController {
        let view = GameDetailViewController(nibName: String(describing: GameDetailViewController.self), bundle: nil)
        let interactor = GameDetailInteractor(gameImageService: container.resolve(GameImageServiceApi.self))
        let router = GameDetailRouter(viewController: view, container: container)
        let presenter = GameDetailPresenter(view: view, interactor: interactor, router: router, game: game)

        view.presenter = presenter
        
        return view
    }
}
