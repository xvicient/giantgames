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
    private let locales: GameDetailLocales
    private let game: Game
    private var images = [GameImage]()
    private var videos = [GameVideo]()
    
    init(view: GameDetailViewProtocol,
         interactor: GameDetailInteractorProtocol,
         router: GameDetailRouterProtocol,
         locales: GameDetailLocales,
         game: Game) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.locales = locales
        self.game = game
    }
}

// MARK: - GameDetailPresenterProtocol

extension GameDetailPresenter: GameDetailPresenterProtocol {
    func viewDidLoad() {
        showView()
        showCover()
        showScreenshots()
        showVideos()
    }

    func didSelectImage(_ index: Int) {
        guard let url = images[index].url(.large) else { return }
        view.render(state: .showFullscreen(url))
    }

    func didSelectVideo(_ index: Int) {
        guard let url = videos[index].url(.embed) else { return }
        router.playVideo(url)
    }
}

// MARK: - Private

private extension GameDetailPresenter {
    func showView() {
        let data = GameDetailViewData(gameName: game.name,
                                      gameStoryline: game.storyline.isEmpty ? game.summary : game.storyline,
                                      imagesTitle: locales.imagesTitle,
                                      videosTitle: locales.videosTitle)
        view.render(state: .showView(data))
    }

    func showCover() {
        guard let coverId = game.cover else { return }
        interactor.coverURL(coverId) { [weak self] result in
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
        guard let screenshotIds = game.screenshots, !screenshotIds.isEmpty else { return }
        interactor.gameImages(screenshotIds) { [weak self] images in
            guard let self = self else { return }
            self.images = images
            self.view.render(state: .showScreenshots(images.compactMap { $0.url(.medium) }))
        }
    }

    func showVideos() {
        guard let videoIds = game.videos, !videoIds.isEmpty else { return }
        interactor.gameVideos(videoIds) { [weak self] videos in
            guard let self = self else { return }
            self.videos = videos
            self.view.render(state: .showVideos(videos.compactMap { $0.url(.embed) }))
        }
    }
}
