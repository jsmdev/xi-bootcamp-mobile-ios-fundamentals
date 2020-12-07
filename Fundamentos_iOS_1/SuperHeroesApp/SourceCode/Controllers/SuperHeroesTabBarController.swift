//
//  SuperHeroesTabBarController.swift
//  Fundamentos_iOS_1
//
//  Created by José Sancho on 7/12/20.
//

import UIKit

private enum TabBarIndex: Int {
    case dc, marvel
}

class SuperHeroesTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        navigationController?.isNavigationBarHidden = false
        if let selectedVC = selectedViewController {
            configure(selectedVC, with: TabBarIndex.dc.hashValue)
        }
    }

    private func configure(_ viewController: UIViewController,
                           with publisher: Int) {
        if let superHeroesVC = viewController as? SuperHeroesViewController {
            switch publisher {
                case TabBarIndex.dc.rawValue:
                    superHeroesVC.publisher = .dc
                    print("DC Comics pressed")
                case TabBarIndex.marvel.rawValue:
                    superHeroesVC.publisher = .marvel
                    print("MARVEL Comics pressed")
                default:
                    break
            }
        }
    }
}

extension SuperHeroesTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        configure(viewController, with: tabBarController.selectedIndex)
    }
}
