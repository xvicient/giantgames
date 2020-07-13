//
//  UITableView+Dequeue.swift
//  GiantGames
//
//  Created by Xavier on 12/07/2020.
//  Copyright © 2020 GiantGames. All rights reserved.
//

import UIKit

// MARK: - Register Cell Nibs

extension UITableView {
    private func registerCell(_ cellId: String) {
        register(UINib(nibName: cellId, bundle: Bundle.main), forCellReuseIdentifier: cellId)
    }

    func registerCells(_ cells: AnyClass ...) {
        cells.forEach { cell in
            let cellId = String.stringFromClass(cell)
            registerCell(cellId)
        }
    }
}

// MARK: - Dequeuing

extension UITableView {
    func dequeue<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        let id = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: id, for: indexPath) as! T
    }
}
