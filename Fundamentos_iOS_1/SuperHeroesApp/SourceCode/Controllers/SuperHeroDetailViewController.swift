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
}
