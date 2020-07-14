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
protocol GameDetailRouterProtocol {}

// MARK: - Presenter

// sourcery: AutoMockable
protocol GameDetailPresenterProtocol {
    func viewDidLoad()
}

// MARK: - Interactor

// sourcery: AutoMockable
protocol GameDetailInteractorProtocol {
    func cover(_ coverId: Int, completion: @escaping (Result<[Cover], APIError>) -> Void)
    func screenshot(_ screenshotId: Int, completion: @escaping (Result<[Screenshot], APIError>) -> Void)
}

// MARK: - View

enum GameDetailViewState {
    case showView(_ data: GameDetailViewData)
    case showCover(_ url: URL)
}

// sourcery: AutoMockable
protocol GameDetailViewProtocol: AnyObject {
    var presenter: GameDetailPresenterProtocol! { get set }
    func render(state: GameDetailViewState)
}
