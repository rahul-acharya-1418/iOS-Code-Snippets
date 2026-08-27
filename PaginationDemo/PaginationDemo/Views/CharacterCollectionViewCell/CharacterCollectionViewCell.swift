//
//  CharacterCollectionViewCell.swift
//  PaginationDemo
//
//  Created by Rahul Acharya on 27/08/26.
//

import UIKit
import SDWebImage

class CharacterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    public func setupConfig(with model: RMCharacter) {
        profileImageView.sd_setImage(with: URL(string: model.image))
        idLabel.text = "\(model.id)"
    }
}
