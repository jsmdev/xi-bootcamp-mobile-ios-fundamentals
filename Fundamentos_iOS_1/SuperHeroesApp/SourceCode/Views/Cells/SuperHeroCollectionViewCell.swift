//
//  SuperHeroCollectionViewCell.swift
//  Fundamentos_iOS_1
//
//  Created by José Sancho on 8/12/20.
//

import UIKit
import Kingfisher

class SuperHeroCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var fotoImageView: UIImageView?
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var publisher: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let width = fotoImageView?.bounds.width {
            fotoImageView?.layer.cornerRadius =  width / 2
        }
        fotoImageView?.layer.borderWidth = 1
        fotoImageView?.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        fotoImageView?.image = nil
        nameLabel?.text = nil
        publisher?.text = nil
    }
    
    func configure(with data: SuperHeroElement) {
        nameLabel?.text = data.name
        publisher?.text = data.biography.publisher?.count ?? 0 <= 0 ? "---" : data.biography.publisher

        if let imageURL = URL(string: data.images.lg) {
            fotoImageView?.kf.setImage(with: imageURL)
        }
    }
}
