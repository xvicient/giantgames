//
//  HomePresenter.swift
//  GiantGames
//
//  Created by Xavier on 12/07/2020.
//  Copyright © 2020 GiantGames All rights reserved.
//

import Foundation

final class HomePresenter {
    private weak var view: HomeViewProtocol!
    private let interactor: HomeInteractorProtocol
    private let router: HomeRouterProtocol
    private let locales: HomeLocales
    private var games = [Game]()
    private let pageSize = 20
    private var currentPage = 1
    private let pagintaionThreshold = 6
    private var pageOffset: Int { currentPage * pageSize }
    private var isFetching = false
    
    init(view: HomeViewProtocol,
         interactor: HomeInteractorProtocol,
         router: HomeRouterProtocol,
         locales: HomeLocales) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.locales = locales
    }
}

// MARK: - HomePresenterProtocol

extension HomePresenter: HomePresenterProtocol {
    func viewDidLoad() {
        showGames()
    }

    func didTapGame(_ index: Int) {
        print(index)
    }

    func willDisplayCell(_ index: Int) {
        guard !isFetching && index >= games.count - pagintaionThreshold else { return }
        showGames()
    }
}

// MARK: - Private

private extension HomePresenter {
    func showGames() {
        isFetching = true
        interactor.games(offset: String(pageOffset)) { [weak self] result in
            guard let self = self else { return }
            self.isFetching = false
            switch result {
            case let .success(games):
                self.games += games
                self.currentPage += 1
                self.view.render(state: .show(games))
            case .failure:
                self.router.show(self.locales.genericErrorMessage, okTitle: self.locales.alertOkTitle)
            }
        }
    }
}
