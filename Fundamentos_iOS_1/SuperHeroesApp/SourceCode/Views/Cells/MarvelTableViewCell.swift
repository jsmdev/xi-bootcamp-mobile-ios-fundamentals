//
//  MarvelTableViewCell.swift
//  Fundamentos_iOS_1
//
//  Created by José Sancho on 7/12/20.
//

import UIKit
import Kingfisher

class MarvelTableViewCell: UITableViewCell {
    @IBOutlet weak var superHeroImageView: UIImageView?
    @IBOutlet weak var superHeroName: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        superHeroImageView?.image = nil
        superHeroName?.text = nil
    }

    func configure(with data: SuperHeroElement) {
        superHeroName?.text = data.name
        if let imageURL = URL(string: data.images.lg) {
            superHeroImageView?.kf.setImage(with: imageURL)
        }
    }

}
