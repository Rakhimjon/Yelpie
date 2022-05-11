//
//  UITableView+Ex.swift
//  RoViu
//
//  Created by KhuongPham on 24/08/2021.
//

import UIKit

/// `UITableView` extensions.
extension UITableView {
    /**
     Register multiple cell classes
     - Parameter cellClass: various cell classes
     */
    func register(_ cellClass: AnyClass...) {
        cellClass.forEach { register($0, forCellReuseIdentifier: String(describing: $0)) }
    }

    /**
     Dequeue reusable cell without casting step
     - Parameter type: cell type
     - Parameter indexPath: indexPath for the cell
     */
    func dequeueReusableCell<Cell>(_ type: Cell.Type, for indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as? Cell else {
            fatalError("Could not dequeue reusable cell for \(type), did you register it?")
        }
        return cell
    }
}
