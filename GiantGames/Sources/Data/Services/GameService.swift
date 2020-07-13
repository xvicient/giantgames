//
//  GameService.swift
//  GiantGames
//
//  Created by Xavier on 12/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

// MARK: - GameServiceApi

protocol GameServiceApi {
    func games(offset: String, completion: @escaping (Result<[Game], APIError>) -> Void)
}

// MARK: - GameService

struct GameService {
    private let apiClient: APIClientApi

    init(apiClient: APIClientApi) {
        self.apiClient = apiClient
    }
}

extension GameService: GameServiceApi {
    func games(offset: String, completion: @escaping (Result<[Game], APIError>) -> Void) {
        apiClient.request(.games(offset: offset)) { (result: Result<[GameCodable], APIError>) in
            let games = result.map { $0.map { $0.toDomain() }}
            completion(games)
        }
    }
}
