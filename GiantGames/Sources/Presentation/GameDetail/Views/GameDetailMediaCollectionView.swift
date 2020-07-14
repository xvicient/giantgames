//
//  GameDetailMediaCollectionView.swift
//  GiantGames
//
//  Created by Xavier on 14/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

import UIKit

class GameDetailMediaCollectionView: UICollectionView {
    var urls = [URL]() {
        didSet {
            reloadData()
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
}

// MARK: - Private

private extension GameDetailMediaCollectionView {
    func setup() {
        registerCells(GameDetailMediaCollectionViewCell.self)
        delegate = self
        dataSource = self
    }
}

// MARK: - GameDetailViewProtocol

extension GameDetailMediaCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        urls.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GameDetailMediaCollectionViewCell = collectionView.dequeue(for: indexPath)
        cell.setup(urls[indexPath.row])
        return cell
    }
}
