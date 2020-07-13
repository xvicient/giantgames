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
    
    init(view: HomeViewProtocol,
         interactor: HomeInteractorProtocol,
         router: HomeRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension HomePresenter: HomePresenterProtocol {
    func viewDidLoad() {
        interactor.games { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(games):
                print("")
            case let .failure(error): break
            }
        }
    }
}
