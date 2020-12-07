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
    @IBOutlet weak var tableView: UITableView?

    let superHeroesList = SuperHeroRepository.shared.superHeroes
    var superHeroesFilterd = SuperHeroes()
    var publisher: Publisher

    init?(coder: NSCoder, publisher: Publisher) {
        self.publisher = publisher
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = self
        tableView?.dataSource = self
        filterSuperHeroesByUniverse()
    }

    private func filterSuperHeroesByUniverse() {
        switch publisher {
            case .dc:
                //                superHeroesFilterd = superHeroesList.filter({ $0.biography.publisher == Publisher.dc.rawValue })
                superHeroesFilterd = superHeroesList.filter({ (superHero) -> Bool in
                    return superHero.biography.publisher == Publisher.dc.rawValue
                })
                print(superHeroesFilterd.count)
            case .marvel:
                //                superHeroesFilterd = superHeroesList.filter({ $0.biography.publisher == Publisher.marvel.rawValue })
                superHeroesFilterd = superHeroesList.filter({ (superHero) -> Bool in
                    return superHero.biography.publisher == Publisher.marvel.rawValue
                })
                print(superHeroesFilterd.count)
        }
    }
}

extension SuperHeroesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return superHeroesFilterd.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = superHeroesFilterd[indexPath.row].name + " --> " + publisher.rawValue
        return cell
    }


}

extension SuperHeroesViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {

    }
}

extension SuperHeroesViewController: UITableViewDelegate {

}
