//
//  DCSuperHeroesViewController.swift
//  Fundamentos_iOS_1
//
//  Created by José Sancho on 7/12/20.
//

import UIKit
import Kingfisher

class DCSuperHeroesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView?
    var dcSuperHeroes = SuperHeroes()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        configureSearchController()
        dcSuperHeroes = applyDcFilter()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SuperHeroDetailViewController,
           let superHero = sender as? SuperHeroElement {
            destination.superHero = superHero
        }
    }

    private func configureViewController() {
        title = "DC Universe"
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

    private func applyDcFilter() -> SuperHeroes {
        return SuperHeroRepository.shared.superHeroes.filter({ (superHero) -> Bool in
            return superHero.biography.publisher == Publisher.dc.rawValue
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
        let filteredDcSuperHeroes = applyDcFilter()
        switch alignmentTitle {
            case "Super Heroes":
                dcSuperHeroes = filteredDcSuperHeroes.filter({return $0.biography.alignment == Alignment.good })
            case "Neutral Heroes":
                dcSuperHeroes = filteredDcSuperHeroes.filter({return $0.biography.alignment == Alignment.neutral })
            case "Super Villains":
                dcSuperHeroes = filteredDcSuperHeroes.filter({return $0.biography.alignment == Alignment.bad })
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
        dcSuperHeroes = applyDcFilter()
        updateTableView()
    }
}

extension DCSuperHeroesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dcSuperHeroes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.superHeroTableView,
                                                 for: indexPath) as? SuperHeroTableViewCell
        if(indexPath.row < dcSuperHeroes.count) {
            cell?.configure(with: dcSuperHeroes[indexPath.row])
        }
        return cell ?? UITableViewCell()
    }
}

extension DCSuperHeroesViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let urls = indexPaths.compactMap { URL(string: dcSuperHeroes[$0.row].images.lg) }
        ImagePrefetcher(urls: urls).start()
    }
}

extension DCSuperHeroesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < dcSuperHeroes.count {
            performSegue(withIdentifier: Segues.fromDCToDetail,
                         sender: dcSuperHeroes[indexPath.row])
        }
    }
}

extension DCSuperHeroesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.lowercased() else { return }
        dcSuperHeroes = SuperHeroRepository.shared.superHeroes.filter({ (superHero) -> Bool in
            return superHero.name.lowercased().contains(text)
        })
        if dcSuperHeroes.count <= 0 {
            applyDcFilter()
        }
        tableView?.reloadData()
    }
}
