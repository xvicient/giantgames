//
//  ScreenshotService.swift
//  GiantGames
//
//  Created by Xavier on 14/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

// MARK: - CoverServiceApi

// sourcery: AutoMockable
protocol ScreenshotServiceApi {
    func screenshot(_ screenshotId: Int, completion: @escaping (Result<[Screenshot], APIError>) -> Void)
}

// MARK: - ScreenshotService

struct ScreenshotService {
    private let apiClient: APIClientApi

    init(apiClient: APIClientApi) {
        self.apiClient = apiClient
    }
}

extension ScreenshotService: ScreenshotServiceApi {
    func screenshot(_ screenshotId: Int, completion: @escaping (Result<[Screenshot], APIError>) -> Void) {
        apiClient.request(.screenshot(screenshotId)) { (result: Result<[ScreenshotCodable], APIError>) in
            completion(result.map { $0.map { $0.toDomain() }})
        }
    }
}
