//
//  AllSuperHeroesViewController.swift
//  Fundamentos_iOS_1
//
//  Created by José Sancho on 8/12/20.
//

import UIKit
import Kingfisher

class AllSuperHeroesViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView?

    var superHeroes = SuperHeroRepository.shared.superHeroes

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.prefetchDataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter by", style: .plain, target: self, action: #selector(filterBy))
        title = "Super Heroes"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SuperHeroDetailViewController,
           let superHero = sender as? SuperHeroElement {
            destination.superHero = superHero
        }
    }

    @objc private func filterBy() {
        let ac = UIAlertController(title: "Filter heroes by alignment...", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: Alignment.good.rawValue.capitalized, style: .default, handler: filter))
        ac.addAction(UIAlertAction(title: Alignment.neutral.rawValue.capitalized, style: .default, handler: filter))
        ac.addAction(UIAlertAction(title: Alignment.bad.rawValue.capitalized, style: .destructive, handler: filter))
        ac.addAction(UIAlertAction(title: "All", style: .cancel, handler: filter))
        present(ac, animated: true)
    }

    func filter(action: UIAlertAction) {
        guard let alignment = action.title?.lowercased() else {
            return
        }
        let allSuperHeroes = SuperHeroRepository.shared.superHeroes
        switch alignment {
            case Alignment.good.rawValue:
                superHeroes = allSuperHeroes.filter({return $0.biography.alignment == Alignment.good })
            case Alignment.neutral.rawValue:
                superHeroes = allSuperHeroes.filter({return $0.biography.alignment == Alignment.neutral })
            case Alignment.bad.rawValue:
                superHeroes = allSuperHeroes.filter({return $0.biography.alignment == Alignment.bad })
            default:
                superHeroes = allSuperHeroes
        }
        collectionView?.reloadData()
//        collectionView?.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    }
}

extension AllSuperHeroesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = UIScreen.main.bounds.width / 3 - (8 + 8 + 16 + 16)
        let cellHeight = cellWidth + 60
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension AllSuperHeroesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return superHeroes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.superHeroCollection,
                                                      for: indexPath) as? SuperHeroCollectionViewCell
        if(indexPath.row < superHeroes.count) {
            cell?.configure(with: superHeroes[indexPath.row])
        }
        return cell ?? UICollectionViewCell()
    }
}

extension AllSuperHeroesViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let urls = indexPaths.compactMap { URL(string: superHeroes[$0.row].images.lg) }
        ImagePrefetcher(urls: urls).start()
    }
}

extension AllSuperHeroesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < superHeroes.count {
            performSegue(withIdentifier: Segues.fromAllSuperHeroesToDetail,
                         sender: superHeroes[indexPath.row])
        }
    }
}
