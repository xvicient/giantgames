//
//  HomeViewController.swift
//  GiantGames
//
//  Created by Xavier on 12/07/2020.
//  Copyright © 2020 GiantGames All rights reserved.
//

import UIKit

struct HomeViewData: Equatable {
    let viewTitle: String
}

struct HomeViewItem: Equatable {
    let nameText: String
    let summaryText: String
    let ratingTitle: String
    let ratingText: String
    let releasedTitle: String
    let releaseDate: String
}

struct HomeViewLoadingData: Equatable {
    let position: Position
    let on: Bool

    enum Position: Equatable {
        case top
        case middle
        case bottom
    }
}

final class HomeViewController: UIViewController {
    var presenter: HomePresenterProtocol!
    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.registerCells(GameCell.self)

            let refreshControl = UIRefreshControl()
            refreshControl.tintColor = .white
            refreshControl.addTarget(self, action: #selector(didRefresh), for: .valueChanged)
            tableView.refreshControl = refreshControl
            
            let bottomLoading = UIActivityIndicatorView(style: .medium)
            bottomLoading.color = .white
            bottomLoading.frame = CGRect(x: 0.0, y: 0.0, width: tableView.bounds.width, height: 44.0)
            tableView.tableFooterView = bottomLoading
        }
    }
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    private var paginationThreshold: Int!
    private var items = [HomeViewItem]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onViewWillAppear()
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
        case let .showView(data):
            showView(data)
        case let .showItems(items):
            showItems(items)
        case let .showLoading(loading):
            showLoading(loading)
        }
    }
}

// MARK: - Private

private extension HomeViewController {
    func onViewWillAppear() {
        view.addGradient([.yellow, .purple])
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }

    func onViewDidLoad() {
        overrideUserInterfaceStyle = .light
    }

    func showView(_ data: HomeViewData) {
        title = data.viewTitle
    }

    func showItems(_ items: [HomeViewItem]) {
        self.items.append(contentsOf: items)
    }

    func showLoading(_ loading: HomeViewLoadingData) {
        switch loading.position {
        case .top:
            guard !loading.on else { return }
            tableView.refreshControl?.endRefreshing()
        case .middle:
            loading.on ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        case .bottom:
            guard let bottomLoading = tableView.tableFooterView as? UIActivityIndicatorView else { return }
            loading.on ? bottomLoading.startAnimating() : bottomLoading.stopAnimating()
            tableView.tableFooterView?.isHidden = !loading.on
        }
    }

    @objc func didRefresh(_ : UIRefreshControl) {
        presenter.didRefresh()
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GameCell = tableView.dequeue(for: indexPath)
        cell.setup(items[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didTapGame(indexPath.row)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter.willDisplayCell(indexPath.row)
    }
}
