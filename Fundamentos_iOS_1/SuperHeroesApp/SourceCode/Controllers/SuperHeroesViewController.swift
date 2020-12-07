//
//  SuperHeroesViewController.swift
//  Fundamentos_iOS_1
//
//  Created by José Sancho on 7/12/20.
//

import UIKit

enum Publisher: String {
    case dc = "DC Comics"
    case marvel = "Marvel Comics"
}

class SuperHeroesViewController: UIViewController {
    let superHeroesList = SuperHeroRepository.shared.superHeroes
    var superHeroesFilterd = SuperHeroes()
    var publisher = Publisher.dc

    override func viewDidLoad() {
        super.viewDidLoad()
        filterSuperHeroesByUniverse()
    }

    private func filterSuperHeroesByUniverse() {
        switch publisher {
            case .dc:
                superHeroesFilterd = superHeroesList.filter({ $0.biography.publisher == Publisher.dc.rawValue })
            case .marvel:
                superHeroesFilterd = superHeroesList.filter({ $0.biography.publisher == Publisher.marvel.rawValue })
        }
    }
}
