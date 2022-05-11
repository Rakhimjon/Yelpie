//
//  UICollectionView+Ex.swift
//  RoViu
//
//  Created by KhuongPham on 25/08/2021.
//

import UIKit

/// `UITableView` extensions.
extension UICollectionView {
    /**
     Register multiple cell classes
     - Parameter cellClass: various cell classes
     */
    func register(_ cellClass: AnyClass...) {
        cellClass.forEach { register($0, forCellWithReuseIdentifier: String(describing: $0)) }
    }

    /**
     Dequeue reusable cell without casting step
     - Parameter type: cell type
     - Parameter indexPath: indexPath for the cell
     */
    func dequeueReusableCell<Cell>(_ cellClass: Cell.Type, for indexPath: IndexPath) -> Cell {
        return dequeueReusableCell(withReuseIdentifier: String(describing: cellClass), for: indexPath) as! Cell
    }
}
