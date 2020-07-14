//
//  GameDetailInteractor.swift
//  GiantGames
//
//  Created by Xavier on 13/07/2020.
//  Copyright © 2020 GiantGames All rights reserved.
//

import Foundation

final class GameDetailInteractor {
    let gameImageService: GameImageServiceApi

    init(gameImageService: GameImageServiceApi) {
        self.gameImageService = gameImageService
    }
}

extension GameDetailInteractor: GameDetailInteractorProtocol {
    func coverURL(_ id: Int, completion: @escaping (Result<URL?, APIError>) -> Void) {
        gameImageService.cover(id) {
            completion($0.map { $0.compactMap { $0.url(.medium) }.first })
        }
    }

    func screenshotURLs(_ ids: [Int], completion: @escaping ([URL]) -> Void) {
        var screenshotURLs = [URL]()
        let group = DispatchGroup()

        ids.forEach { [weak self] id in
            group.enter()
            self?.screenshotURL(id) {
                if case let .success(url) = $0, let screenshotURL = url {
                    screenshotURLs += [screenshotURL]
                }
                group.leave()
            }
        }

        group.notify(queue: .main) { completion(screenshotURLs) }
    }
}

private extension GameDetailInteractor {
    func screenshotURL(_ id: Int, completion: @escaping (Result<URL?, APIError>) -> Void) {
        gameImageService.screenshot(id) {
            completion($0.map { $0.compactMap { $0.url(.large) }.first })
        }
    }
}
