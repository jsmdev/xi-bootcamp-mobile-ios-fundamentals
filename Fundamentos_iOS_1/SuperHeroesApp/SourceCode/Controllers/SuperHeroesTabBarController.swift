//
//  SuperHeroesTabBarController.swift
//  Fundamentos_iOS_1
//
//  Created by José Sancho on 7/12/20.
//

import UIKit

class SuperHeroesTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        navigationController?.isNavigationBarHidden = false
    }
}

extension SuperHeroesTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        if let dcVC = viewController.children.first as? DCSuperHeroesViewController {
            dcVC.tableView?.scrollToRow(at: IndexPath(row: 0, section: 0),
                                        at: .top,
                                        animated: true)
        } else if let marvelVC = viewController.children.first as? MarvelSuperHeroesViewController {
            marvelVC.tableView?.scrollToRow(at: IndexPath(row: 0, section: 0),
                                        at: .top,
                                        animated: true)
        } else if let alllVC = viewController.children.first as? AllSuperHeroesViewController {
            alllVC.collectionView?.scrollToItem(at: IndexPath(row: 0, section: 0),
                                                at: .top,
                                                animated: true)
        }
    }
}
