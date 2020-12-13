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
        configureViewController()
        configureTableView()
        configureSearchController()
        marvelSuperHeroes = applyMarvelFilter()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SuperHeroDetailViewController,
           let superHero = sender as? SuperHeroElement {
            destination.superHero = superHero
        }
    }

    private func configureViewController() {
        title = "MARVEL Universe"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter by", style: .plain, target: self, action: #selector(filterBy))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Show all", style: .plain, target: self, action: #selector(showAll))
    }

    private func configureTableView() {
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.prefetchDataSource = self
    }

    private func configureSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search super heroes..."
        navigationItem.searchController = searchController
    }

    private func applyMarvelFilter() -> SuperHeroes {
        return SuperHeroRepository.shared.superHeroes.filter({ (superHero) -> Bool in
            return superHero.biography.publisher == Publisher.marvel.rawValue
        })
    }

    private func updateTableView() {
        tableView?.reloadData {
            self.tableView?.scrollToRow(at: IndexPath(row: 0, section: 0),
                                        at: .top,
                                        animated: true)
        }
    }

    private func filterByAlignment(action: UIAlertAction) {
        guard let alignmentTitle = action.title else {
            return
        }
        let filteredMarvelSuperHeroes = applyMarvelFilter()
        switch alignmentTitle {
            case "Super Heroes":
                marvelSuperHeroes = filteredMarvelSuperHeroes.filter({return $0.biography.alignment == Alignment.good })
            case "Neutral Heroes":
                marvelSuperHeroes = filteredMarvelSuperHeroes.filter({return $0.biography.alignment == Alignment.neutral })
            case "Super Villains":
                marvelSuperHeroes = filteredMarvelSuperHeroes.filter({return $0.biography.alignment == Alignment.bad })
            default:
                break
        }
        updateTableView()
    }

    @objc private func filterBy() {
        let ac = UIAlertController(title: "Filter by...", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Super Heroes", style: .default, handler: filterByAlignment))
        ac.addAction(UIAlertAction(title: "Neutral Heroes", style: .default, handler: filterByAlignment))
        ac.addAction(UIAlertAction(title: "Super Villains", style: .destructive, handler: filterByAlignment))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }

    @objc func showAll() {
        marvelSuperHeroes = applyMarvelFilter()
        updateTableView()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.superHeroTableView,
                                                 for: indexPath) as? SuperHeroTableViewCell
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
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row < marvelSuperHeroes.count {
            performSegue(withIdentifier: Segues.fromMarvelToDetail,
                         sender: marvelSuperHeroes[indexPath.row])
        }
    }
}

extension MarvelSuperHeroesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.lowercased() else { return }
        marvelSuperHeroes = SuperHeroRepository.shared.superHeroes.filter({ (superHero) -> Bool in
            return superHero.name.lowercased().contains(text)
        })
        if marvelSuperHeroes.count <= 0 {
            marvelSuperHeroes = applyMarvelFilter()
        }
        tableView?.reloadData()
    }
}
