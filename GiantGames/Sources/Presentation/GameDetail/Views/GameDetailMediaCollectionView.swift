//
//  GameDetailMediaCollectionView.swift
//  GiantGames
//
//  Created by Xavier on 14/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

import UIKit

class GameDetailMediaCollectionView: UICollectionView {
    private var urls = [URL]()
    private var type: GameDetailViewMediaData.MediaType = .image

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func show(_ data: GameDetailViewMediaData) {
        urls = data.urls
        type = data.type
        reloadData()
    }
}

// MARK: - Private

private extension GameDetailMediaCollectionView {
    func setup() {
        registerCells(GameDetailImageCollectionViewCell.self,
                      GameDetailVideoCollectionViewCell.self)
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
        switch type {
        case .image:
            let cell: GameDetailImageCollectionViewCell = collectionView.dequeue(for: indexPath)
            cell.setup(urls[indexPath.row])
            return cell
        case .video:
            let cell: GameDetailVideoCollectionViewCell = collectionView.dequeue(for: indexPath)
            return cell
        }
    }
}
