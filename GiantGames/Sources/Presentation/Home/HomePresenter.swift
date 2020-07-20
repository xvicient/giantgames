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
    private let pageSize = 10
    private var currentPage = 0
    private let pagintaionThreshold = 2
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
        showView()
        showTopGames(.middle)
    }

    func didTapGame(_ index: Int) {
        router.showGameDetail(games[index])
    }

    func willDisplayCell(_ index: Int) {
        guard !isFetching && index >= games.count - pagintaionThreshold else { return }
        showTopGames(.bottom)
    }

    func didRefresh() {
        games = []
        showTopGames(.top)
    }
}

// MARK: - Private

private extension HomePresenter {
    func showView() {
        view.render(state: .showView(HomeViewData(viewTitle: locales.topGamesTitle)))
    }

    func showTopGames(_ position: HomeViewLoadingData.Position) {
        view.render(state: .showLoading(HomeViewLoadingData(position: position, on: true)))
        isFetching = true
        interactor.topGames(offset: String(pageOffset)) { [weak self] result in
            guard let self = self else { return }
            self.view.render(state: .showLoading(HomeViewLoadingData(position: position, on: false)))
            self.isFetching = false
            switch result {
            case let .success(games):
                self.games += games
                self.currentPage += 1
                let items = games.map { HomeViewItem(nameText: $0.name,
                                                     summaryText: $0.summary,
                                                     ratingTitle: self.locales.scoreTitle.uppercased(),
                                                     ratingText: $0.rating,
                                                     releasedTitle: self.locales.releasedTitle.uppercased(),
                                                     releaseDate: DateFormatter.ddMMyyyy.string(from: $0.releaseDate))}
                self.view.render(state: .showItems(items))
            case .failure:
                self.router.show(self.locales.genericErrorMessage, okTitle: self.locales.alertOkTitle)
            }
        }
    }
}
