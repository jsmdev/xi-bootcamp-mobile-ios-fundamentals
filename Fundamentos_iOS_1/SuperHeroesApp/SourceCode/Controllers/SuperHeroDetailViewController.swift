//
//  SuperHeroDetailViewController.swift
//  Fundamentos_iOS_1
//
//  Created by José Sancho on 7/12/20.
//

import UIKit

class SuperHeroDetailViewController: UIViewController {
    var superHero: SuperHeroElement?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = superHero?.name
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
}
