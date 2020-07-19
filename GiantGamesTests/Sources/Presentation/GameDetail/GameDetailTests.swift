// 
//  GameDetailTests.swift
//  GiantGamesTests
//
//  Created by Xavier on 15/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

import SwiftyMocky
import Swinject
import XCTest

@testable import GiantGames

// MARK: - View tests

class GameDetailViewTests: XCTestCase {
    private var view: GameDetailViewController!
    private let presenterMock = GameDetailPresenterProtocolMock(sequencing: .lastWrittenResolvedFirst, stubbing: .wrap)

    override func setUp() {
        super.setUp()
        setupView()
    }

    override func tearDown() {
        super.tearDown()
    }
}

private extension GameDetailViewTests {
    func setupView() {
        view = GameDetailViewController(nibName: nil, bundle: nil)
        view.presenter = presenterMock
    }
}

// MARK: - Presenter tests

class GameDetailPresenterTests: XCTestCase {
    private var presenter: GameDetailPresenter!
    private let interactorMock = GameDetailInteractorProtocolMock(sequencing: .lastWrittenResolvedFirst, stubbing: .wrap)
    private let routerMock = GameDetailRouterProtocolMock(sequencing: .lastWrittenResolvedFirst, stubbing: .wrap)
    private let viewMock = GameDetailViewProtocolMock(sequencing: .lastWrittenResolvedFirst, stubbing: .wrap)
    private let locales = GameDetailLocales()
    private let game = GameMock.game
    private let coverURLMock = URL(string: "https://www.google.com/")!
    private let gameImages = GameImageMock.gameImages(5)
    private let gameVideos = GameVideoMock.gameVideos(5)

    override func setUp() {
        super.setUp()
        setupPresenter()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_showView() {
        presenter.viewDidLoad()

        let data = GameDetailViewData(gameName: game.name,
                                      gameStoryline: game.storyline,
                                      imagesTitle: locales.imagesTitle,
                                      videosTitle: locales.videosTitle)
        Verify(viewMock, 1, .render(state: .value(.showView(data))))
    }

    func test_showCover() {
        mockCover(.success(coverURLMock))
        presenter.viewDidLoad()

        Verify(interactorMock, 1, .coverURL(.value(game.cover), completion: .any))
        Verify(viewMock, 1, .render(state: .value(.showCover(coverURLMock))))
    }

    func test_showScreenshots() {
        mockScreenshots(gameImages)
        presenter.viewDidLoad()

        Verify(interactorMock, 1, .gameImages(.value(game.screenshots!), completion: .any))
        Verify(viewMock, 1, .render(state: .value(.showScreenshots(gameImages.compactMap { $0.url(.medium) }))))
    }

    func test_showVideos() {
        mockVideos(gameVideos)
        presenter.viewDidLoad()

        Verify(interactorMock, 1, .gameVideos(.value(game.videos!), completion: .any))
        Verify(viewMock, 1, .render(state: .value(.showVideos(gameVideos.compactMap { $0.url(.embed) }))))

    }

    func test_imageSelected() {
        mockScreenshots(gameImages)
        presenter.viewDidLoad()

        let imageIndex = 0
        presenter.didSelectImage(imageIndex)

        Verify(viewMock, 1, .render(state: .value(.showFullscreen(gameImages[imageIndex].url(.large)!))))
    }

    func test_videoSelected() {
        mockVideos(gameVideos)
        presenter.viewDidLoad()

        let videoIndex = 0
        presenter.didSelectVideo(videoIndex)

        Verify(routerMock, 1, .playVideo(.value(gameVideos[videoIndex].url(.embed)!)))
    }
}

private extension GameDetailPresenterTests {
    func setupPresenter() {
        presenter = GameDetailPresenter(view: viewMock,
                                        interactor: interactorMock,
                                        router: routerMock,
                                        locales: locales,
                                        game: game)
    }

    func mockCover(_ result: Result<URL?, APIError>) {
        Perform(interactorMock, .coverURL(.value(game.cover),
                                          completion: .any,
                                          perform: { (_, completion) in
                                            completion(result)
        }))
    }

    func mockScreenshots(_ result: [GameImage]) {
        Perform(interactorMock, .gameImages(.value(game.screenshots!),
                                            completion: .any,
                                            perform: { (_, completion) in
                                                completion(result)
        }))
    }

    func mockVideos(_ result: [GameVideo]) {
        Perform(interactorMock, .gameVideos(.value(game.videos!),
                                            completion: .any,
                                            perform: { (_, completion) in
                                                completion(result)
        }))
    }
}

// MARK: - Interactor tests

class GameDetailInteractorTests: XCTestCase {
    private var interactor: GameDetailInteractor!
    private let presenterMock = GameDetailPresenterProtocolMock(sequencing: .lastWrittenResolvedFirst, stubbing: .wrap)
    private let gameImageServiceApiMock = GameImageServiceApiMock(sequencing: .lastWrittenResolvedFirst, stubbing: .wrap)
    private let gamevideoServiceApiMock = GameVideoServiceApiMock(sequencing: .lastWrittenResolvedFirst, stubbing: .wrap)

    override func setUp() {
        super.setUp()
        setupInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }
}

private extension GameDetailInteractorTests {
    func setupInteractor() {
        interactor = GameDetailInteractor(gameImageService: gameImageServiceApiMock,
                                          gameVideoService: gamevideoServiceApiMock)
    }
}

// MARK: - Router tests

class GameDetailRouterTests: XCTestCase {
    private var router: GameDetailRouter!
    private let container: DependencyInjectionApi = DependencyInjectionFactory.make(DependenciesRegistration())

    override func setUp() {
        super.setUp()
        setupRouter()
    }

    override func tearDown() {
        super.tearDown()
    }
}

private extension GameDetailRouterTests {
    func setupRouter() {
        router = GameDetailRouter(viewController: UIViewController(nibName: nil, bundle: nil), container: container)
    }
}
