//
//  GameDetailPresenter.swift
//  GiantGames
//
//  Created by Xavier on 13/07/2020.
//  Copyright © 2020 GiantGames All rights reserved.
//

import Foundation

final class GameDetailPresenter {
    private weak var view: GameDetailViewProtocol!
    private let interactor: GameDetailInteractorProtocol
    private let router: GameDetailRouterProtocol
    
    init(view: GameDetailViewProtocol,
         interactor: GameDetailInteractorProtocol,
         router: GameDetailRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension GameDetailPresenter: GameDetailPresenterProtocol {
    func viewDidLoad() {}
}
