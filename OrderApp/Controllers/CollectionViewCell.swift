//
//  CollectionViewCell.swift
//  OrderApp
//
//  Created by ForMore on 13/10/2023.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = "CollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with model: Menu) {
        self.imageView.image = UIImage(named: model.imageName)
        self.titleLabel.text = model.title
    }

    static func nib() -> UINib {
        return UINib(nibName: "CollectionViewCell", bundle: nil)
    }
}
