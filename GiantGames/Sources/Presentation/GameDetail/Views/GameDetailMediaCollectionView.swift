//
//  GameDetailMediaCollectionView.swift
//  GiantGames
//
//  Created by Xavier on 14/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

import UIKit

protocol GameDetailMediaCollectionViewDelegate: class {
    func didSelectVideo(_ index: Int)
    func didSelectImage(_ index: Int)
}

enum GameDetailMediaCollectionType {
    case image
    case video
}

class GameDetailMediaCollectionView: UICollectionView {
    weak var mediaDelegate: GameDetailMediaCollectionViewDelegate?
    var type: GameDetailMediaCollectionType?
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
        switch type! {
        case .image:
            let cell: GameDetailImageCollectionViewCell = collectionView.dequeue(for: indexPath)
            cell.setup(urls[indexPath.row])
            return cell
        case .video:
            let cell: GameDetailVideoCollectionViewCell = collectionView.dequeue(for: indexPath)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch type! {
        case .image: mediaDelegate?.didSelectImage(indexPath.row)
        case .video: mediaDelegate?.didSelectVideo(indexPath.row)
        }
    }
}
