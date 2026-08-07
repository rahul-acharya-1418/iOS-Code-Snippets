//
//  ChannelCollectionViewCell.swift
//  CollectionViewDemo
//
//  Created by Rahul Acharya on 07/08/26.
//

import UIKit

class ChannelCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier: String = "ChannelCollectionViewCell"
    
    private let view: UIView = {
       let view = UIView()
        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(view)
        
            NSLayoutConstraint.activate([
                view.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: spacingConstant),
                view.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -spacingConstant),
                view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: spacingConstant),
                view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -spacingConstant),
            ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
}
