//
//  SectionIndexCompositeViewController.swift
//  CollectionViewDemo
//
//  Created by Rahul Acharya on 07/08/26.
//

import UIKit

class SectionIndexCompositeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch sectionIndex {
            case 0:
                return self.heroSection()
            case 1:
                return self.categorySection()
            case 2,3:
                return self.appStoreContentSection()
            case 4,5:
                return self.contentSection()
            case 6:
                return self.paginationLayout()
            default:
                return self.contentSection()
            }
        }
        
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "cell1")
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "cell2")
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "cell3")
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "cell4")
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "cell5")
        
        collectionView.register(
            UICollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "ReusableCell"
        )
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension SectionIndexCompositeViewController {
    
    private func heroSection() -> NSCollectionLayoutSection {

        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(500)
            ),
            subitems: [item]
        )

        return NSCollectionLayoutSection(group: group)
    }
    
    private func categorySection() -> NSCollectionLayoutSection {

        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )

        item.contentInsets = .init(top: 2, leading: 5, bottom: 2, trailing: 5)

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(100),
                heightDimension: .absolute(50)
            ),
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous

        return section
    }
    
    private func contentSection() -> NSCollectionLayoutSection {

        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )

        item.contentInsets = .init(top: 2, leading: 5, bottom: 2, trailing: 5)

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0/3),
                heightDimension: .fractionalWidth(1.0/2)
            ),
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(40)
                ),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
        ]

        return section
    }
    
    private func appStoreContentSection() -> NSCollectionLayoutSection {

        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0 / 3.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )

        item.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2
        )

        // One row (3 items)
        let horizontalGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)
            ),
            subitem: item,
            count: 3
        )

        // Two rows
        let verticalGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.9), // width of one "page"
                heightDimension: .absolute(220)
            ),
            subitem: horizontalGroup,
            count: 2
        )

        let section = NSCollectionLayoutSection(group: verticalGroup)
        section.orthogonalScrollingBehavior = .groupPaging

        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(40)
                ),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
        ]

        return section
    }
    
    private func paginationLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )

        item.contentInsets = .init(top: 2, leading: 5, bottom: 2, trailing: 5)

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(100)
            ),
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging

        return section
    }
}


extension SectionIndexCompositeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        7
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 20
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
         case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath)
            cell.backgroundColor = .systemBlue
            return cell
         case 1:
               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath)
               cell.backgroundColor = .systemGray
               return cell
         case 2,3:
               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath)
               cell.backgroundColor = .systemBrown
               return cell
         case 6:
               let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell5", for: indexPath)
               cell.backgroundColor = .systemTeal
               return cell
         default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell4", for: indexPath)
            cell.backgroundColor = .systemGreen
            return cell
         }
    }
}

extension SectionIndexCompositeViewController {
    
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
