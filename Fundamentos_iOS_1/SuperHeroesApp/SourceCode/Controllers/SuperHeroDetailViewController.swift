//
//  SuperHeroDetailViewController.swift
//  Fundamentos_iOS_1
//
//  Created by José Sancho on 7/12/20.
//

import UIKit
import Cosmos
import Agrume

class SuperHeroDetailViewController: UIViewController {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var fotoImageView: UIImageView?
    @IBOutlet weak var fullNameLabel: UILabel?
    @IBOutlet weak var genderLabel: UILabel?
    @IBOutlet weak var raceLabel: UILabel?
    @IBOutlet weak var heightLabel: UILabel?
    @IBOutlet weak var weightLabel: UILabel?
    @IBOutlet weak var eyeColorLabel: UILabel?
    @IBOutlet weak var hairColorLabel: UILabel?
    @IBOutlet weak var appearanceLabel: UILabel!
    @IBOutlet weak var intelligenceRatingView: CosmosView!
    @IBOutlet weak var strengthRatingView: CosmosView!
    @IBOutlet weak var speedRatingView: CosmosView!
    @IBOutlet weak var durabilityRatingView: CosmosView!
    @IBOutlet weak var powerRatingView: CosmosView!
    @IBOutlet weak var combatRatingView: CosmosView!
    @IBOutlet weak var buttonBackgroundView: UIView!
    @IBOutlet weak var alignmentBackgroundView: UIView?
    @IBOutlet weak var alignmentLabel: UILabel?

    var superHero: SuperHeroElement?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        setData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    private func configureViewController() {
        title = superHero?.name
        buttonBackgroundView?.layer.cornerRadius = CGFloat(6)
        alignmentBackgroundView?.layer.cornerRadius = CGFloat(Values.cornerRadius / 2)
    }

    private func setData() {
        if let object = superHero, let imageURL = URL(string: object.images.lg) {
            fotoImageView?.kf.setImage(with: imageURL)
        }
        let fullName = superHero?.biography.fullName.count ?? 0 <= 0 ? superHero?.name : superHero?.biography.fullName
        let publisher = superHero?.biography.publisher
        fullNameLabel?.text = "\(fullName ?? "") (\(publisher ?? ""))"
        genderLabel?.text = superHero?.appearance.gender.rawValue.count ?? 0 <= 0 ? "-" : superHero?.appearance.gender.rawValue
        raceLabel?.text = superHero?.appearance.race?.count ?? 0 <= 0 ? "-" : superHero?.appearance.race
        heightLabel?.text = superHero?.appearance.height.last?.count ?? 0 <= 0 ? "-" : superHero?.appearance.height.last
        weightLabel?.text = superHero?.appearance.weight.last?.count ?? 0 <= 0 ? "-" : superHero?.appearance.weight.last
        eyeColorLabel?.text = superHero?.appearance.eyeColor.count ?? 0 <= 0 ? "-" : superHero?.appearance.eyeColor
        hairColorLabel?.text = superHero?.appearance.hairColor.count ?? 0 <= 0 ? "-" : superHero?.appearance.hairColor

        if let alignment = superHero?.biography.alignment {
            alignmentLabel?.text = alignment.rawValue.capitalized
            switch alignment {
                case .good:
                    alignmentBackgroundView?.backgroundColor = .systemGreen
                case .neutral:
                    alignmentBackgroundView?.backgroundColor = .systemBlue
                case .bad:
                    alignmentBackgroundView?.backgroundColor = .systemRed
            }
        }
        if let intelligenceValue = superHero?.powerstats.intelligence {
            intelligenceRatingView.rating = Double(intelligenceValue) / 10.0
            intelligenceRatingView.text = "(\(intelligenceValue))"
        }
        if let strenghtValue = superHero?.powerstats.strength {
            strengthRatingView.rating = Double(strenghtValue) / 10.0
            strengthRatingView.text = "(\(strenghtValue))"
        }
        if let speedValue = superHero?.powerstats.speed {
            speedRatingView.rating = Double(speedValue) / 10.0
            speedRatingView.text = "(\(speedValue))"
        }
        if let durabilityValue = superHero?.powerstats.durability {
            durabilityRatingView.rating = Double(durabilityValue) / 10.0
            durabilityRatingView.text = "(\(durabilityValue))"
        }
        if let powerValue = superHero?.powerstats.power {
            powerRatingView.rating = Double(powerValue) / 10.0
            powerRatingView.text = "(\(powerValue))"
        }
        if let combatValue = superHero?.powerstats.combat {
            combatRatingView.rating = Double(combatValue) / 10.0
            combatRatingView.text = "(\(combatValue))"
        }
    }

    @IBAction func openImage(_ sender: Any) {
        if let image = fotoImageView?.image {
            let agrume = Agrume(image: image, dismissal: .withButton(nil))
            agrume.show(from: self)
        }
    }
}
