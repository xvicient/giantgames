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

extension HomeRouter: HomeRouterProtocol {}
