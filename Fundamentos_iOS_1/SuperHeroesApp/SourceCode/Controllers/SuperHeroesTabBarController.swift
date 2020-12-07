//
//  SuperHeroesTabBarController.swift
//  Fundamentos_iOS_1
//
//  Created by José Sancho on 7/12/20.
//

import UIKit

class SuperHeroesTabBarController: UITabBarController {
    var superHeroes = [SuperHeroElement]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    private func loadData() {
        let namefile = "SuperHeroes"
        if let fileUrl = Bundle.main.url(forResource: namefile, withExtension: "json") {
            do {
                // Get data from file
                let data = try Data(contentsOf: fileUrl)
                // Decode data to a super heroes list
                let superHeroesList = try JSONDecoder().decode([SuperHeroElement].self, from: data)
                superHeroes = superHeroesList
            } catch {
                // Print error if something went wrong
                print("JSON Parser error: \(error)")
                return
            }
        }
    }
}
