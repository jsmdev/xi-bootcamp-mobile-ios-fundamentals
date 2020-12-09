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
        fotoImageView?.layer.shadowColor = UIColor.gray.cgColor
        fotoImageView?.layer.shadowOffset = CGSize.zero
        fotoImageView?.layer.shadowOpacity = Values.cornerRadius
        fotoImageView?.layer.shadowRadius = CGFloat(Values.shadowOpacity)
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
