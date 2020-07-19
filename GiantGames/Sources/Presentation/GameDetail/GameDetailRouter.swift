//
//  GameDetailRouter.swift
//  GiantGames
//
//  Created by Xavier on 13/07/2020.
//  Copyright © 2020 GiantGames All rights reserved.
//

import UIKit
import SafariServices

final class GameDetailRouter {
    private weak var viewController: UIViewController!
    private let container: DependencyInjectionApi
    
    init(viewController: UIViewController, container: DependencyInjectionApi) {
        self.viewController = viewController
        self.container = container
    }
}

extension GameDetailRouter: GameDetailRouterProtocol {
    func playVideo(_ url: URL) {
        let safari = SFSafariViewController(url: url)
        safari.modalPresentationStyle = .overFullScreen
        viewController.present(safari, animated: true)
    }
}
