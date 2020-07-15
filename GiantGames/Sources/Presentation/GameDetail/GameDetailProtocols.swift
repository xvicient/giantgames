//
//  GameDetailProtocols.swift
//  GiantGames
//
//  Created by Xavier on 13/07/2020.
//  Copyright © 2020 GiantGames All rights reserved.
//

import UIKit

// MARK: - Builder

// sourcery: AutoMockable
protocol GameDetailBuilderProtocol {
    func buildModule(_ game: Game) -> UIViewController
}

// MARK: - Router

// sourcery: AutoMockable
protocol GameDetailRouterProtocol {
    func playVideo(_ url: URL)
}

// MARK: - Presenter

// sourcery: AutoMockable
protocol GameDetailPresenterProtocol {
    func viewDidLoad()
    func didSelectVideo(_ index: Int)
}

// MARK: - Interactor

// sourcery: AutoMockable
protocol GameDetailInteractorProtocol {
    func coverURL(_ id: Int, completion: @escaping (Result<URL?, APIError>) -> Void)
    func screenshotURLs(_ id: [Int], completion: @escaping ([URL]) -> Void)
    func videoURLs(_ ids: [Int], completion: @escaping ([URL]) -> Void)
}

// MARK: - View

enum GameDetailViewState {
    case showView(_ data: GameDetailViewData)
    case showCover(_ url: URL)
    case showMedia(_ data: GameDetailViewMediaData)
}

// sourcery: AutoMockable
protocol GameDetailViewProtocol: AnyObject {
    var presenter: GameDetailPresenterProtocol! { get set }
    func render(state: GameDetailViewState)
}
