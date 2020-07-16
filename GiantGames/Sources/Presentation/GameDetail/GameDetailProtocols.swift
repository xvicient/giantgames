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
    func didSelectImage(_ index: Int)
    func didSelectVideo(_ index: Int)
}

// MARK: - Interactor

// sourcery: AutoMockable
protocol GameDetailInteractorProtocol {
    func coverURL(_ id: Int, completion: @escaping (Result<URL?, APIError>) -> Void)
    func gameImages(_ ids: [Int], completion: @escaping ([GameImage]) -> Void)
    func videoURLs(_ ids: [Int], completion: @escaping ([URL]) -> Void)
}

// MARK: - View

enum GameDetailViewState: Equatable {
    case showView(_ data: GameDetailViewData)
    case showCover(_ url: URL)
    case showScreenshots(_ urls: [URL])
    case showVideos(_ urls: [URL])
    case showFullscreen(_ url: URL)
}

// sourcery: AutoMockable
protocol GameDetailViewProtocol: AnyObject {
    var presenter: GameDetailPresenterProtocol! { get set }
    func render(state: GameDetailViewState)
}
