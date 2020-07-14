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
        showScreenshots()
    }
}

// MARK: - Private

private extension GameDetailPresenter {
    func showView() {
        let data = GameDetailViewData(gameName: game.name, gameStoryline: game.storyline)
        view.render(state: .showView(data))
    }

    func showCover() {
        interactor.coverURL(game.cover) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(coverURL):
                guard let url = coverURL else { return }
                self.view.render(state: .showCover(url))
            case .failure: break
            }
        }
    }

    func showScreenshots() {
        guard let screenshotIds = game.screenshots else { return }
        interactor.screenshotURLs(screenshotIds) { [weak self] urls in
            guard let self = self else { return }
            self.view.render(state: .showScreenshots(urls))
        }
    }
}
