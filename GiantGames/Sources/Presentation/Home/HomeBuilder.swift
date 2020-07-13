//
//  HomeBuilder.swift
//  GiantGames
//
//  Created by Xavier on 12/07/2020.
//  Copyright © 2020 GiantGames All rights reserved.
//

import UIKit

final class HomeBuilder {
    private let container: DependencyInjectionApi

    init(container: DependencyInjectionApi) {
        self.container = container
    }
}

extension HomeBuilder: HomeBuilderProtocol {
    func buildModule() -> UIViewController {
        let view = HomeViewController(nibName: String(describing: HomeViewController.self), bundle: nil)
        let interactor = HomeInteractor(gameService: container.resolve(GameServiceApi.self))
        let router = HomeRouter(viewController: view, container: container)
        let presenter = HomePresenter(view: view, interactor: interactor, router: router)

        view.presenter = presenter
        
        return view
    }
}
