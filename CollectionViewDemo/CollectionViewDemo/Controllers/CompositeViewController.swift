//
//  CompositeViewController.swift
//  CollectionViewDemo
//
//  Created by Rahul Acharya on 07/08/26.
//

import UIKit

class CompositeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = cellLayout()
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "cell")
        collectionView.register(
            UICollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "ReusableCell"
        )
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension CompositeViewController {
    
    
    func cellLayout() -> UICollectionViewCompositionalLayout {
        // Create item size
        let newWidthDimension =  (1.0/3.0)
        let newHeightDimension =  (1.0/2.0)
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(newWidthDimension),
            heightDimension: .fractionalWidth(newHeightDimension)
        )
        let item = NSCollectionLayoutItem(
            layoutSize: itemSize
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
        
        // Create group with horizontal scrolling
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(newHeightDimension)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        // Create section
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,//20,
            bottom: 0,
            trailing: 0
        )
        
        section.orthogonalScrollingBehavior = .continuous // Horizontal scrolling for items
        
        // Add header to the section
        let sectionHeightDimension: CGFloat = 40 //100 // header height
        
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(sectionHeightDimension)
                ),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
        ]
        
        // Create layout
        let layout = UICollectionViewCompositionalLayout(
            section: section
        )
        
        return layout
    }
}

extension CompositeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemGreen
        return cell
    }
}

extension CompositeViewController {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "ReusableCell",
                for: indexPath)
            headerView.backgroundColor = .red
            return headerView
        }
        return UICollectionReusableView()
    }
}
