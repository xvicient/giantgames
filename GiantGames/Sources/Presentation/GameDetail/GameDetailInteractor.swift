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
    func cover(_ coverId: Int, completion: @escaping (Result<[Cover], APIError>) -> Void) {
        coverService.cover(coverId) {
            completion($0.map { $0.filter { $0.url != nil } })
        }
    }

    func screenshot(_ screenshotId: Int, completion: @escaping (Result<[Screenshot], APIError>) -> Void) {
        screenshotService.screenshot(screenshotId) {
            completion($0.map { $0.filter { $0.url != nil } })
        }
    }
}
