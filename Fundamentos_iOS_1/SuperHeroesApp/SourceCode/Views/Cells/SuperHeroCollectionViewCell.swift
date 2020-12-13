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
    @IBOutlet weak var alignmentBackgroundView: UIView?
    @IBOutlet weak var alignmentLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let width = fotoImageView?.bounds.width {
            fotoImageView?.layer.cornerRadius =  width / 2
        }
        fotoImageView?.layer.borderWidth = 1
        fotoImageView?.layer.borderColor = UIColor.lightGray.cgColor
        alignmentBackgroundView?.layer.cornerRadius = CGFloat(Values.cornerRadius / 2)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        fotoImageView?.image = nil
        nameLabel?.text = nil
        publisher?.text = nil
        alignmentLabel?.text = nil
        alignmentBackgroundView?.backgroundColor = .clear
    }
    
    func configure(with data: SuperHeroElement) {
        if let imageURL = URL(string: data.images.lg) {
            fotoImageView?.kf.setImage(with: imageURL)
        }
        nameLabel?.text = data.name
        publisher?.text = data.biography.publisher?.count ?? 0 <= 0 ? "---" : data.biography.publisher
        alignmentLabel?.text = data.biography.alignment.rawValue.capitalized
        switch data.biography.alignment {
            case .good:
                alignmentBackgroundView?.backgroundColor = .systemGreen
            case .neutral:
                alignmentBackgroundView?.backgroundColor = .systemBlue
            case .bad:
                alignmentBackgroundView?.backgroundColor = .systemRed
        }
    }
}
