//
//  UICollectionView+Extensions.swift
//  Fundamentos_iOS_1
//
//  Created by José Sancho on 10/12/20.
//

import UIKit

extension UITableView {
    func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
}
