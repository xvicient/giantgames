//
//  GameDetailInteractor.swift
//  GiantGames
//
//  Created by Xavier on 13/07/2020.
//  Copyright © 2020 GiantGames All rights reserved.
//

import Foundation

final class GameDetailInteractor {
    let coverService: CoverServiceApi
    let screenshotService: ScreenshotServiceApi

    init(coverService: CoverServiceApi,
         screenshotService: ScreenshotServiceApi) {
        self.coverService = coverService
        self.screenshotService = screenshotService
    }
}

extension GameDetailInteractor: GameDetailInteractorProtocol {
    func coverURL(_ coverId: Int, completion: @escaping (Result<URL?, APIError>) -> Void) {
        coverService.cover(coverId) {
            completion($0.map { $0.compactMap { $0.url }.first })
        }
    }

    func screenshotURLs(_ screenshotIds: [Int], completion: @escaping ([URL]) -> Void) {
        var screenshotURLs = [URL]()
        let group = DispatchGroup()

        screenshotIds.forEach { [weak self] screenshotId in
            group.enter()
            self?.screenshotURL(screenshotId) {
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
    func screenshotURL(_ screenshotId: Int, completion: @escaping (Result<URL?, APIError>) -> Void) {
        screenshotService.screenshot(screenshotId) {
            completion($0.map { $0.compactMap { $0.url }.first })
        }
    }
}
