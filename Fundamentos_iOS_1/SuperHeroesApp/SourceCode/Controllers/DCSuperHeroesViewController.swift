//
//  DCSuperHeroesViewController.swift
//  Fundamentos_iOS_1
//
//  Created by José Sancho on 7/12/20.
//

import UIKit

class DCSuperHeroesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView?
    
    var dcSuperHeroes = SuperHeroes()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = self
        tableView?.dataSource = self
        applyPublisherFilter()
    }

    private func applyPublisherFilter() {
        dcSuperHeroes =  SuperHeroRepository.shared.superHeroes.filter({ (superHero) -> Bool in
            return superHero.biography.publisher == Publisher.dc.rawValue
        })
        print(dcSuperHeroes.count)
    }
}

extension DCSuperHeroesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dcSuperHeroes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = dcSuperHeroes[indexPath.row].name + " --> " + Publisher.dc.rawValue
        return cell
    }


}

extension DCSuperHeroesViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {

    }
}

extension DCSuperHeroesViewController: UITableViewDelegate {

}
