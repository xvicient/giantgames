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
    private let game: Game
    
    init(view: GameDetailViewProtocol,
         interactor: GameDetailInteractorProtocol,
         router: GameDetailRouterProtocol,
         game: Game) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.game = game
    }
}

// MARK: - GameDetailPresenterProtocol

extension GameDetailPresenter: GameDetailPresenterProtocol {
    func viewDidLoad() {
        showView()
        showCover()
    }
}

// MARK: - Private

private extension GameDetailPresenter {
    func showView() {
        let data = GameDetailViewData(gameName: game.name, gameStoryline: game.storyline)
        view.render(state: .showView(data))
    }

    func showCover() {
        interactor.cover(game.cover) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(cover):
                self.view.render(state: .showCover(cover.first!.url!))
            case .failure: break
            }
        }
    }
}
