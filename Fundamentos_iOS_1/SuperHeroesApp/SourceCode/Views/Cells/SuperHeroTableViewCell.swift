//
//  SuperHeroTableViewCell.swift
//  Fundamentos_iOS_1
//
//  Created by José Sancho on 7/12/20.
//

import UIKit
import Kingfisher

class SuperHeroTableViewCell: UITableViewCell {
    @IBOutlet weak var contentBackgroundView: UIView?
    @IBOutlet weak var fotoImageView: UIImageView?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var nameBackgroundView: UIView?
    @IBOutlet weak var fullNameLabel: UILabel?
    @IBOutlet weak var genderLabel: UILabel?
    @IBOutlet weak var raceLabel: UILabel?
    @IBOutlet weak var heightLabel: UILabel?
    @IBOutlet weak var weightLabel: UILabel?
    @IBOutlet weak var eyeColorLabel: UILabel?
    @IBOutlet weak var hairColorLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()

        contentBackgroundView?.layer.cornerRadius = CGFloat(Values.cornerRadius)
        contentBackgroundView?.layer.shadowColor = UIColor.clear.cgColor
        contentBackgroundView?.layer.shadowOffset = CGSize(width: 6, height: 6) // CGSize.zero
        contentBackgroundView?.layer.shadowOpacity = Values.cornerRadius
        contentBackgroundView?.layer.shadowRadius = CGFloat(Values.shadowOpacity)

        fotoImageView?.layer.cornerRadius = CGFloat(Values.cornerRadius)
        fotoImageView?.layer.shadowColor = UIColor.gray.cgColor
        fotoImageView?.layer.shadowOffset = CGSize.zero
        fotoImageView?.layer.shadowOpacity = Values.cornerRadius
        fotoImageView?.layer.shadowRadius = CGFloat(Values.shadowOpacity)

        nameLabel?.layer.cornerRadius = CGFloat(Values.cornerRadius)
        nameLabel?.layer.maskedCorners = [.layerMinXMaxYCorner,
                                          .layerMaxXMaxYCorner]

        nameBackgroundView?.layer.cornerRadius = CGFloat(Values.cornerRadius)
        nameBackgroundView?.layer.maskedCorners = [.layerMinXMaxYCorner,
                                                   .layerMaxXMaxYCorner]
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        fotoImageView?.image = nil
        nameLabel?.text = nil
        fullNameLabel?.text = nil
        genderLabel?.text = nil
        raceLabel?.text = nil
        heightLabel?.text = nil
        weightLabel?.text = nil
        eyeColorLabel?.text = nil
        hairColorLabel?.text = nil
    }

    func configure(with data: SuperHeroElement) {
        nameLabel?.text = data.name
        fullNameLabel?.text = data.biography.fullName.count <= 0 ? data.name : data.biography.fullName
        genderLabel?.text = data.appearance.gender.rawValue.count <= 0 ? "-" : data.appearance.gender.rawValue
        raceLabel?.text = data.appearance.race?.count ?? 0 <= 0 ? "-" : data.appearance.race
        heightLabel?.text = data.appearance.height.last?.count ?? 0 <= 0 ? "-" : data.appearance.height.last
        weightLabel?.text = data.appearance.weight.last?.count ?? 0 <= 0 ? "-" : data.appearance.weight.last
        eyeColorLabel?.text = data.appearance.eyeColor.count <= 0 ? "-" : data.appearance.eyeColor
        hairColorLabel?.text = data.appearance.hairColor.count <= 0 ? "-" : data.appearance.hairColor

        if let imageURL = URL(string: data.images.lg) {
            fotoImageView?.kf.setImage(with: imageURL)
        }
    }

}
