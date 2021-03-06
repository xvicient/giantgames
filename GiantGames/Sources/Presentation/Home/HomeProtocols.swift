//
//  HomeProtocols.swift
//  GiantGames
//
//  Created by Xavier on 12/07/2020.
//  Copyright © 2020 GiantGames All rights reserved.
//

import UIKit

// MARK: - Builder

// sourcery: AutoMockable
protocol HomeBuilderProtocol {
    func buildModule() -> UIViewController
}

// MARK: - Router

// sourcery: AutoMockable
protocol HomeRouterProtocol {
    func show(_ message: String, okTitle: String)
    func showGameDetail(_ game: Game)
}

// MARK: - Presenter

// sourcery: AutoMockable
protocol HomePresenterProtocol {
    func viewDidLoad()
    func didTapGame(_ index: Int)
    func willDisplayCell(_ index: Int)
    func didRefresh()
}

// MARK: - Interactor

// sourcery: AutoMockable
protocol HomeInteractorProtocol {
    func topGames(offset: String, completion: @escaping (Result<[Game], APIError>) -> Void)
}

// MARK: - View

enum HomeViewState: Equatable {
    case showView(_ data: HomeViewData)
    case showItems(_ games: [HomeViewItem])
    case showLoading(_ loading: HomeViewLoadingData)
}

// sourcery: AutoMockable
protocol HomeViewProtocol: AnyObject {
    var presenter: HomePresenterProtocol! { get set }
    func render(state: HomeViewState)
}
