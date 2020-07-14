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

    init(coverService: CoverServiceApi) {
        self.coverService = coverService
    }
}

extension GameDetailInteractor: GameDetailInteractorProtocol {
    func cover(_ coverId: Int, completion: @escaping (Result<[Cover], APIError>) -> Void) {
        coverService.cover(coverId) {
            completion($0.map { $0.filter { $0.url != nil } })
        }
    }
}
