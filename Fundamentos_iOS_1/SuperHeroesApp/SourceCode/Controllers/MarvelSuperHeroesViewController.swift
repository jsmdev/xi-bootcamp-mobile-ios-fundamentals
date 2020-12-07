//
//  MarvelSuperHeroesViewController.swift
//  Fundamentos_iOS_1
//
//  Created by José Sancho on 7/12/20.
//

import UIKit

class MarvelSuperHeroesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView?

    var marvelSuperHeroes = SuperHeroes()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = self
        tableView?.dataSource = self
        applyPublisherFilter()
    }

    private func applyPublisherFilter() {
        marvelSuperHeroes =  SuperHeroRepository.shared.superHeroes.filter({ (superHero) -> Bool in
            return superHero.biography.publisher == Publisher.marvel.rawValue
        })
        print(marvelSuperHeroes.count)
    }
}

extension MarvelSuperHeroesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marvelSuperHeroes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = marvelSuperHeroes[indexPath.row].name + " --> " + Publisher.marvel.rawValue
        return cell
    }


}

extension MarvelSuperHeroesViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {

    }
}

extension MarvelSuperHeroesViewController: UITableViewDelegate {

}
