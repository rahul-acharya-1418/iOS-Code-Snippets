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

        /// 4️⃣ Create transformer USING imageView size
        /// Force SDWebImage to downscale images before decoding
        /// SDWebImage transformer runs BEFORE the image reaches UIImageView
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
                .scaleDownLargeImages   // 🔥  CRITICAL
            ],
            context: [
                .imageTransformer: transformer
            ]
        )
        
        /// Add a completion block to confirm images ARE downloading
        profileImageView.sd_setImage(
            with: url,
            placeholderImage: UIImage(named: "Logo"),
            options: [.retryFailed, .refreshCached]
        ) { image, error, _, imageURL in
            if let error {
                print("❌ Image error:", error, imageURL?.absoluteString ?? "")
            } else {
                print("✅ Image loaded:", imageURL?.absoluteString ?? "")
            }
        }
        
        /// ✅ Image downloads successfully
        /// ❌ Image fails to decode into memory on tvOS
        /// ❌ Resulting bitmap = 0×0 pixels
        /// ❌ SDWebImage refuses to render it
        
        /*
         SOME IDs fail (100, 102, 104, 105, 106)
         
         | Issue               | Explanation                   |
         | ------------------- | ----------------------------- |
         | Very large PNGs     | Some are 8–15MB uncompressed  |
         | High resolution     | Designed for web, not TV      |
         | No size constraints | Decoded at full resolution    |
         | tvOS memory cap     | Much stricter than iOS        |
         | Focus scrolling     | Causes rapid decode + release |
         
         Result → memory spike → decoder fails → 0 pixels


         🧪 WHY .scaleDownLargeImages FIXES IT
         
         | Without              | With                 |
         | -------------------- | -------------------- |
         | Decodes full 4K+ PNG | Decodes to cell size |
         | GPU memory spike     | Safe memory usage    |
         | 0-pixel images       | Stable rendering     |
         | Random failures      | 100% reliable        |

         */
    }
}
