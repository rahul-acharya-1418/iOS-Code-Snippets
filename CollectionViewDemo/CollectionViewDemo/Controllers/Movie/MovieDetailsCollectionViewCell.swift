//
//  MovieDetailsCollectionViewCell.swift
//  CollectionViewDemo
//
//  Created by Rahul Acharya on 03/11/26.
//

import UIKit

class MovieDetailsCollectionViewCell: UICollectionViewCell {
    
    private let descriptionLabel: UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(descriptionLabel)
        addConstrains()
        descriptionLabel.text = """
                A feature documentary about J. Robert Oppenheimer's role in the development of the atomic bomb. Physicist J. Robert Oppenheimer works with a team of scientists during the Manhattan Project, leading to the development of the atomic bomb. The film explores the moral weight and historical impact of their discovery during World War II and the subsequent security hearing in 1954.
                A feature documentary about J. Robert Oppenheimer's role in the development of the atomic bomb. Physicist J. Robert Oppenheimer works with a team of scientists during the Manhattan Project, leading to the development of the atomic bomb. The film explores the moral weight and historical impact of their discovery during World War II and the subsequent security hearing in 1954.
                A feature documentary about J. Robert Oppenheimer's role in the development of the atomic bomb. Physicist J. Robert Oppenheimer works with a team of scientists during the Manhattan Project, leading to the development of the atomic bomb. The film explores the moral weight and historical impact of their discovery during World War II and the subsequent security hearing in 1954.
                A feature documentary about J. Robert Oppenheimer's role in the development of the atomic bomb. Physicist J. Robert Oppenheimer works with a team of scientists during the Manhattan Project, leading to the development of the atomic bomb. The film explores the moral weight and historical impact of their discovery during World War II and the subsequent security hearing in 1954.
                A feature documentary about J. Robert Oppenheimer's role in the development of the atomic bomb. Physicist J. Robert Oppenheimer works with a team of scientists during the Manhattan Project, leading to the development of the atomic bomb. The film explores the moral weight and historical impact of their discovery during World War II and the subsequent security hearing in 1954.
                A feature documentary about J. Robert Oppenheimer's role in the development of the atomic bomb. Physicist J. Robert Oppenheimer works with a team of scientists during the Manhattan Project, leading to the development of the atomic bomb. The film explores the moral weight and historical impact of their discovery during World War II and the subsequent security hearing in 1954.
                A feature documentary about J. Robert Oppenheimer's role in the development of the atomic bomb. Physicist J. Robert Oppenheimer works with a team of scientists during the Manhattan Project, leading to the development of the atomic bomb. The film explores the moral weight and historical impact of their discovery during World War II and the subsequent security hearing in 1954.
                """
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        descriptionLabel.text = nil
    }
    
    func addConstrains() {
        NSLayoutConstraint.activate([
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
}
