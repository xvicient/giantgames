//
//  HomeInteractor.swift
//  GiantGames
//
//  Created by Xavier on 12/07/2020.
//  Copyright © 2020 GiantGames All rights reserved.
//

import Foundation

final class HomeInteractor {
    let gameService: GameServiceApi

    init(gameService: GameServiceApi) {
        self.gameService = gameService
    }
}

extension HomeInteractor: HomeInteractorProtocol {
    func games(completion: @escaping (Result<[Game], APIError>) -> Void) {
        gameService.games(completion: completion)
    }
}
