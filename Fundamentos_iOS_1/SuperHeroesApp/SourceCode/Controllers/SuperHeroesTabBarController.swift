//
//  SuperHeroesTabBarController.swift
//  Fundamentos_iOS_1
//
//  Created by José Sancho on 7/12/20.
//

import UIKit

class SuperHeroesTabBarController: UITabBarController, UITabBarControllerDelegate {
    var superHeroes: SuperHeroes {
        return SuperHeroRepository.shared.superHeroes
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }

    // UITabBarDelegate
    override func tabBar(_ tabBar: UITabBar,
                         didSelect item: UITabBarItem) {
        print("Selected item")
    }

    // UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController,
                          didSelect viewController: UIViewController) {
        print("Selected view controller")
    }
}
