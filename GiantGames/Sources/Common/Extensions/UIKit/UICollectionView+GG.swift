//
//  UICollectionView+GG.swift
//  GiantGames
//
//  Created by Xavier on 14/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

import UIKit

// MARK: - Register Cell Nibs

extension UICollectionView {
    private func registerCell(_ cellId: String) {
        register(UINib(nibName: cellId, bundle: Bundle.main), forCellWithReuseIdentifier: cellId)
    }

    func registerCells(_ cells: AnyClass ...) {
        cells.forEach { cell in
            let cellId = String.stringFromClass(cell)
            registerCell(cellId)
        }
    }
}

// MARK: - Dequeuing

extension UICollectionView {
    func dequeue<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        let id = String(describing: T.self)
        return dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as! T
    }
}
