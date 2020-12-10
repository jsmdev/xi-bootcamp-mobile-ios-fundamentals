//
//  AllSuperHeroesViewController.swift
//  Fundamentos_iOS_1
//
//  Created by José Sancho on 8/12/20.
//

import UIKit
import Kingfisher

private enum FilterOption: String {
    case alignment = "Alignment"
    case gender = "Gender"
    case publisher = "Publisher"
}

class AllSuperHeroesViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView?

    var superHeroes = SuperHeroRepository.shared.superHeroes

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.prefetchDataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter by", style: .plain, target: self, action: #selector(filterBy))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "All", style: .plain, target: self, action: #selector(showAll))
        title = "Super Heroes"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SuperHeroDetailViewController,
           let superHero = sender as? SuperHeroElement {
            destination.superHero = superHero
        }
    }

    @objc func showAll() {
        superHeroes = SuperHeroRepository.shared.superHeroes
        updateCollectionView()
    }
    
    @objc private func filterBy() {
        let ac = UIAlertController(title: "Filter heroes by...", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Alignment", style: .default, handler: showAlignmentFilter))
        ac.addAction(UIAlertAction(title: "Gender", style: .default, handler: showGenderFilter))
        ac.addAction(UIAlertAction(title: "Publisher", style: .default, handler: showPublisherFilter))
        ac.addAction(UIAlertAction(title: "All", style: .cancel, handler: showAllSuperHeroes))
        present(ac, animated: true)
    }

    func showAlignmentFilter(action: UIAlertAction) {
        let ac = UIAlertController(title: "Filter heroes by alignment...", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: Alignment.good.rawValue.capitalized, style: .default, handler: filterByAlignment))
        ac.addAction(UIAlertAction(title: Alignment.neutral.rawValue.capitalized, style: .default, handler: filterByAlignment))
        ac.addAction(UIAlertAction(title: Alignment.bad.rawValue.capitalized, style: .destructive, handler: filterByAlignment))
        present(ac, animated: true)
    }

    func showGenderFilter(action: UIAlertAction) {
        let ac = UIAlertController(title: "Filter heroes by gender...", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: Gender.female.rawValue.capitalized, style: .default, handler: filterByGender))
        ac.addAction(UIAlertAction(title: Gender.male.rawValue.capitalized, style: .default, handler: filterByGender))
        ac.addAction(UIAlertAction(title: "Undefined", style: .default, handler: filterByGender))
        present(ac, animated: true)
    }

    func showPublisherFilter(action: UIAlertAction) {
        let publisherVC = PublisherTableViewController()
        publisherVC.delegate = self
        present(publisherVC, animated: true)
    }

    func showAllSuperHeroes(action: UIAlertAction) {
        showAll()
    }

    func filterByAlignment(action: UIAlertAction) {
        guard let alignmentTitle = action.title?.lowercased(),
              let alignment = Alignment(rawValue: alignmentTitle) else {
            return
        }
        let allSuperHeroes = SuperHeroRepository.shared.superHeroes
        superHeroes = allSuperHeroes.filter({return $0.biography.alignment == alignment })
        updateCollectionView()
    }

    func filterByGender(action: UIAlertAction) {
        guard let gender = action.title else {
            return
        }
        let allSuperHeroes = SuperHeroRepository.shared.superHeroes
        switch gender {
            case Gender.female.rawValue:
                superHeroes = allSuperHeroes.filter({return $0.appearance.gender == Gender.female })
            case Gender.male.rawValue:
                superHeroes = allSuperHeroes.filter({return $0.appearance.gender == Gender.male })
            default:
                superHeroes = allSuperHeroes.filter({return $0.appearance.gender == Gender.undefined })
        }
        updateCollectionView()
    }

    func filterByPublisher(with name: String) {
        let allSuperHeroes = SuperHeroRepository.shared.superHeroes
        superHeroes = allSuperHeroes.filter({return $0.biography.publisher == name })
        updateCollectionView()
    }

    private func updateCollectionView() {
        collectionView?.reloadData {
            self.collectionView?.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        }
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

extension AllSuperHeroesViewController: PublisherTableViewDelegate {
    func didSelect(_ publisher: String) {
        filterByPublisher(with: publisher)
    }
}
