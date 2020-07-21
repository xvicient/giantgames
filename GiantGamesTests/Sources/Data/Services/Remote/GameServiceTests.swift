//
//  GameServiceTests.swift
//  GiantGamesTests
//
//  Created by Xavier on 20/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

import XCTest
import OHHTTPStubs

@testable import GiantGames

class GameServiceTests: XCTestCase {
    private let container = DependencyInjectionFactory.make(DependenciesRegistration())
    private var service: GameServiceApi!

    override func setUp() {
        super.setUp()
        service = container.resolve(GameServiceApi.self)
        HTTPStubs.removeAllStubs()
    }

    func test_topGamesRequestSuccess() {
        ApiStub.stubRequest("games", statusCode: 200, target: self)
        let expectation = self.expectation(description: "Service called and matches")

        service.topGames(offset: "") {
            switch $0 {
            case let .success(games):
                XCTAssertTrue(games[0].id == 105049)
                XCTAssertTrue(games[0].cover == 75344)
                XCTAssertTrue(games[0].releaseDate == Date(timeIntervalSince1970: 1566259200))
                XCTAssertTrue(games[0].name == "Remnant: From the Ashes")
                XCTAssertTrue(games[0].rating == 76.067518407999)
                XCTAssertTrue(games[0].screenshots == [297966])
                XCTAssertTrue(games[0].storyline == "War is coming to the continent.")
                XCTAssertTrue(games[0].summary == "The world is in ruins.")
                XCTAssertTrue(games[0].videos == [21140])
            case .failure:
                XCTFail("Shouldn't fail")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 0.5, handler: .none)
    }

    func test_topGamesRequestFailure() {
        ApiStub.stubRequest("games", statusCode: 500, target: self)
        let expectation = self.expectation(description: "Service called and matches")

        service.topGames(offset: "") {
            switch $0 {
            case .success:
                XCTFail("Shouldn't succeed")
            case let .failure(error):
                XCTAssertNotNil(error, "Should throw error")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 0.5, handler: .none)
    }

}
