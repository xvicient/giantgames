//
//  HomeViewController.swift
//  GiantGames
//
//  Created by Xavier on 12/07/2020.
//  Copyright © 2020 GiantGames All rights reserved.
//

import UIKit

struct HomeViewData {
    let viewTitle: String
}

final class HomeViewController: UIViewController {
    var presenter: HomePresenterProtocol!
    @IBOutlet private var tableView: UITableView!
    private var paginationThreshold: Int!
    private var games = [Game]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        onViewDidLoad()
    }
}

// MARK: - HomeViewProtocol

extension HomeViewController: HomeViewProtocol {
    func render(state: HomeViewState) {
        switch state {
        case let .show(games):
            show(games)
        }
    }
}

// MARK: - Private

private extension HomeViewController {
    func onViewDidLoad() {
        tableView.registerCells(GameCell.self)
    }

    func show(_ games: [Game]) {
        self.games.append(contentsOf: games)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        games.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GameCell = tableView.dequeue(for: indexPath)
        cell.setup(nameText: games[indexPath.row].name)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didTapGame(indexPath.row)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter.willDisplayCell(indexPath.row)
    }
}
