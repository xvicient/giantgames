// 
//  HomeTests.swift
//  GiantGamesTests
//
//  Created by Xavier on 12/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

import SwiftyMocky
import Swinject
import XCTest

@testable import GiantGames

// MARK: - View tests

class HomeViewTests: XCTestCase {
    private var view: HomeViewController!
    private let presenterMock = HomePresenterProtocolMock(sequencing: .lastWrittenResolvedFirst, stubbing: .wrap)

    override func setUp() {
        super.setUp()
        setupView()
    }

    override func tearDown() {
        super.tearDown()
    }
}

private extension HomeViewTests {
    func setupView() {
        view = HomeViewController(nibName: nil, bundle: nil)
        view.presenter = presenterMock
    }
}

// MARK: - Presenter tests

class HomePresenterTests: XCTestCase {
    private var presenter: HomePresenter!
    private let interactorMock = HomeInteractorProtocolMock(sequencing: .lastWrittenResolvedFirst, stubbing: .wrap)
    private let routerMock = HomeRouterProtocolMock(sequencing: .lastWrittenResolvedFirst, stubbing: .wrap)
    private let viewMock = HomeViewProtocolMock(sequencing: .lastWrittenResolvedFirst, stubbing: .wrap)
    private let locales = HomeLocales()
    private let gamesMock = GameMock.games(20)

    override func setUp() {
        super.setUp()
        setupPresenter()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_showView() {
        presenter.viewDidLoad()
        let data = HomeViewData(viewTitle: locales.topGamesTitle)
        Verify(viewMock, 1, .render(state: .value(.showView(data))))
    }

    func test_showGamesSucceed() {
        mockGames(.success(self.gamesMock))
        presenter.viewDidLoad()
        Verify(interactorMock, 1, .topGames(offset: .value("0"), completion: .any))
        Verify(viewMock, 1, .render(state: .value(.showGames(gamesMock))))
    }

    func test_showGamesFailure() {
        mockGames(.failure(APIError.httpCode(401, nil)))
        presenter.viewDidLoad()
        Verify(routerMock, 1, .show(.value(locales.genericErrorMessage), okTitle: .value(locales.alertOkTitle)))
    }

    func test_showGameDetail() {
        mockGames(.success(self.gamesMock))
        presenter.viewDidLoad()
        let tappedIndex = 0
        presenter.didTapGame(tappedIndex)
        Verify(routerMock, 1, .showGameDetail(.value(gamesMock[tappedIndex].id)))
    }

    func test_paginationNotPerformed() {
        mockGames(.success(self.gamesMock))
        presenter.viewDidLoad()
        presenter.willDisplayCell(13)
        Verify(interactorMock, 0, .topGames(offset: .value("20"), completion: .any))
    }

    func test_paginationPerformed() {
        mockGames(.success(self.gamesMock))
        presenter.viewDidLoad()
        presenter.willDisplayCell(14)
        Verify(interactorMock, 1, .topGames(offset: .value("20"), completion: .any))
    }
}

private extension HomePresenterTests {
    func setupPresenter() {
        presenter = HomePresenter(view: viewMock, interactor: interactorMock, router: routerMock, locales: HomeLocales())
    }

    func mockGames(_ result: Result<[Game], APIError>) {
        Perform(interactorMock, .topGames(offset: .any,
                                          completion: .any,
                                          perform: { (_, completion) in
                                            completion(result)
        }))
    }
}

// MARK: - Interactor tests

class HomeInteractorTests: XCTestCase {
    private var interactor: HomeInteractor!
    private let presenterMock = HomePresenterProtocolMock(sequencing: .lastWrittenResolvedFirst, stubbing: .wrap)
    private let gameServiceApiMock = GameServiceApiMock(sequencing: .lastWrittenResolvedFirst, stubbing: .wrap)

    override func setUp() {
        super.setUp()
        setupInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }
}

private extension HomeInteractorTests {
    func setupInteractor() {
        interactor = HomeInteractor(gameService: gameServiceApiMock)
    }
}

// MARK: - Router tests

class HomeRouterTests: XCTestCase {
    private var router: HomeRouter!
    private let container: DependencyInjectionApi = DependencyInjectionFactory.make(DependenciesRegistration())

    override func setUp() {
        super.setUp()
        setupRouter()
    }

    override func tearDown() {
        super.tearDown()
    }
}

private extension HomeRouterTests {
    func setupRouter() {
        router = HomeRouter(viewController: UIViewController(nibName: nil, bundle: nil), container: container)
    }
}