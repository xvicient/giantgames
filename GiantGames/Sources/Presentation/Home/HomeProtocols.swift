//
//  HomeProtocols.swift
//  GiantGames
//
//  Created by Xavier on 12/07/2020.
//  Copyright © 2020 GiantGames All rights reserved.
//

import UIKit

// MARK: - Builder

// sourcery: AutoMockable
protocol HomeBuilderProtocol {
    func buildModule() -> UIViewController
}

// MARK: - Router

// sourcery: AutoMockable
protocol HomeRouterProtocol {}

// MARK: - Presenter

// sourcery: AutoMockable
protocol HomePresenterProtocol {
    func viewDidLoad()
}

// MARK: - Interactor

// sourcery: AutoMockable
protocol HomeInteractorProtocol {
    func games(completion: @escaping (Result<[Game], APIError>) -> Void)
}

// MARK: - View

enum HomeViewState {}

// sourcery: AutoMockable
protocol HomeViewProtocol: AnyObject {
    var presenter: HomePresenterProtocol! { get set }
    func render(state: HomeViewState)
}
