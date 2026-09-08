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
    
    /// To use this function for Large size image dowload and load to every cell
    /// - Parameter stringImage: image url like this: https://rickandmortyapi.com/api/character/avatar/1.jpeg
    func setupImageViewConfig(with stringImage: String?) {

        // 1️⃣ Reset image for reuse
        profileImageView.image = UIImage(named: "Logo2")

        // 2️⃣ Validate URL
        guard let imageUrlString = stringImage,
              let url = URL(string: imageUrlString)
        else { return }

        // 3️⃣ Ensure imageView has correct size (VERY IMPORTANT)
        profileImageView.layoutIfNeeded()

        // 4️⃣ Create transformer USING imageView size
        let transformer = SDImageResizingTransformer(
            size: profileImageView.bounds.size,
            scaleMode: .aspectFit   // ✅ this matches contentMode
        )

        // 5️⃣ Load image
        profileImageView.sd_setImage(
            with: url,
            placeholderImage: UIImage(named: "Logo2"),
            options: [
                .retryFailed,
                .continueInBackground,
                .scaleDownLargeImages   // 🔥 important for tvOS
            ],
            context: [
                .imageTransformer: transformer
            ]
        )
    }
}
