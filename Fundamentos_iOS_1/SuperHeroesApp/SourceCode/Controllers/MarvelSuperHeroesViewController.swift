//
//  MarvelSuperHeroesViewController.swift
//  Fundamentos_iOS_1
//
//  Created by José Sancho on 7/12/20.
//

import UIKit
import Kingfisher

class MarvelSuperHeroesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView?

    var marvelSuperHeroes = SuperHeroes()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.prefetchDataSource = self
        applyPublisherFilter()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SuperHeroDetailViewController,
           let superHero = sender as? SuperHeroElement {
            destination.superHero = superHero
        }
    }

    private func applyPublisherFilter() {
        marvelSuperHeroes =  SuperHeroRepository.shared.superHeroes.filter({ (superHero) -> Bool in
            return superHero.biography.publisher == Publisher.marvel.rawValue
        })
    }
}

extension MarvelSuperHeroesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marvelSuperHeroes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.marvel,
                                                 for: indexPath) as? MarvelTableViewCell
        if(indexPath.row < marvelSuperHeroes.count) {
            cell?.configure(with: marvelSuperHeroes[indexPath.row])
        }
        return cell ?? UITableViewCell()
    }
}

extension MarvelSuperHeroesViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let urls = indexPaths.compactMap { URL(string: marvelSuperHeroes[$0.row].images.lg) }
        ImagePrefetcher(urls: urls).start()
    }
}

extension MarvelSuperHeroesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < marvelSuperHeroes.count {
            performSegue(withIdentifier: Segues.fromMarvelToDetail,
                         sender: marvelSuperHeroes[indexPath.row])
        }
    }
}
