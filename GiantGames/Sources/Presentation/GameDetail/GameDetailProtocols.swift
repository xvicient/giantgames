//
//  GameDetailProtocols.swift
//  GiantGames
//
//  Created by Xavier on 13/07/2020.
//  Copyright © 2020 GiantGames All rights reserved.
//

import UIKit

// MARK: - Builder

// sourcery: AutoMockable
protocol GameDetailBuilderProtocol {
    func buildModule() -> UIViewController
}

// MARK: - Router

// sourcery: AutoMockable
protocol GameDetailRouterProtocol {}

// MARK: - Presenter

// sourcery: AutoMockable
protocol GameDetailPresenterProtocol {
    func viewDidLoad()
}

// MARK: - Interactor

// sourcery: AutoMockable
protocol GameDetailInteractorProtocol {}

// MARK: - View

enum GameDetailViewState {}

// sourcery: AutoMockable
protocol GameDetailViewProtocol: AnyObject {
    var presenter: GameDetailPresenterProtocol! { get set }
    func render(state: GameDetailViewState)
}
