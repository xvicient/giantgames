//
//  CoverService.swift
//  GiantGames
//
//  Created by Xavier on 14/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

// MARK: - CoverServiceApi

// sourcery: AutoMockable
protocol CoverServiceApi {
    func cover(_ coverId: Int, completion: @escaping (Result<[Cover], APIError>) -> Void)
}

// MARK: - CoverService

struct CoverService {
    private let apiClient: APIClientApi

    init(apiClient: APIClientApi) {
        self.apiClient = apiClient
    }
}

extension CoverService: CoverServiceApi {
    func cover(_ coverId: Int, completion: @escaping (Result<[Cover], APIError>) -> Void) {
        apiClient.request(.cover(coverId)) { (result: Result<[CoverCodable], APIError>) in
            completion(result.map { $0.map { $0.toDomain() }})
        }
    }
}
