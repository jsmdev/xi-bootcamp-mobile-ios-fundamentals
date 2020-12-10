//
//  PublisherTableViewController.swift
//  Fundamentos_iOS_1
//
//  Created by José Sancho on 10/12/20.
//

import UIKit

protocol PublisherTableViewDelegate: AnyObject {
    func didSelect(_ publisher: String)
}

class PublisherTableViewController: UITableViewController {
    var publisherSet = Set<String>()
    var publishers = [String]()
    weak var delegate: PublisherTableViewDelegate? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    private func loadData() {

        let superHeroes = SuperHeroRepository.shared.superHeroes
        for object in superHeroes.enumerated() {
            if let publisher = object.element.biography.publisher {
                publisherSet.insert(publisher)
            }
        }
        publishers = publisherSet.sorted()
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return publishers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if indexPath.row < publishers.count {
            cell.textLabel?.text = publishers[indexPath.row]
        }
        return cell
    }

    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) {
            self.delegate?.didSelect(self.publishers[indexPath.row])
        }
    }
}
