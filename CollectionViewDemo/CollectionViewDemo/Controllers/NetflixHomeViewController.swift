//
//  NetflixHomeViewController.swift
//  CollectionViewDemo
//
//  Created by Rahul Acharya on 22/10/26.
//

import UIKit

class NetflixHomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var sections: [HomeSection] = []
    var counter: Int = 0
    
    // MARK: - Section Type
    
    enum HomeSection: CaseIterable {
        case banner
        case continueWatching
        case newReleases
        case trending
        case explorePartnerHotels
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sections = [
            .banner,
            .continueWatching,
            .trending,
            .newReleases,
            .explorePartnerHotels
        ]
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.setCollectionViewLayout(
            makeCollectionViewLayout(),
            animated: false
        )
        collectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: "cell"
        )
        
        collectionView.register(
            UICollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "SectionHeader"
        )
        collectionView.reloadData()
        timerConfig()
    }
    
    func timerConfig() {
        Timer.scheduledTimer(withTimeInterval: 3.5, repeats: true) { t in
            self.counter += 1
            if self.counter > 4 {
                self.counter = 0
            }
            UIView.animate(withDuration: 0.25) {
                self.collectionView.scrollToItem(
                    at: IndexPath(row: self.counter, section: 0),
                    at: .centeredHorizontally,
                    animated: true
                )
            }
        }
    }
}


extension NetflixHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections[section] {
        case .banner:
            5
        case .continueWatching:
            10
        case .newReleases:
            15
        case .trending:
            10
        case .explorePartnerHotels:
            5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        switch sections[indexPath.section] {
        case .banner:
            cell.backgroundColor = .red
        case .continueWatching:
            cell.backgroundColor = .green
        case .newReleases:
            cell.backgroundColor = .blue
        case .trending:
            cell.backgroundColor = .yellow
        case .explorePartnerHotels:
            cell.backgroundColor = .systemPink
        }
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "SectionHeader",
            for: indexPath
        )
        
        // Configure your header view here
        header.backgroundColor = .lightGray
        
        return header
    }
}

// MARK: - Collection View Layout
extension NetflixHomeViewController {
    
    func makeCollectionViewLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self,
                  sections.indices.contains(sectionIndex) else {
                return nil
            }
            
            return makeLayout(for: sections[sectionIndex])
        }
    }
    
    func makeLayout(for section: HomeSection) -> NSCollectionLayoutSection {
        switch section {
        case .banner:
            return makeBannerSectionLayout()
            
        case .continueWatching:
            return makeContinueWatchingSectionLayout()
            
        case .newReleases:
            return makeNewReleasesSectionLayout()
            
        case .trending:
            return makeTrendingSectionLayout()
            
        case .explorePartnerHotels:
            return makePartnerHotelsSectionLayout()
        }
    }
    
    // MARK: - Section Layouts
    
    func makeBannerSectionLayout() -> NSCollectionLayoutSection {
        let item = makeItem(
            width: .fractionalWidth(1.0),
            height: .fractionalHeight(1.0),
            insets: NSDirectionalEdgeInsets(
                top: 2,
                leading: 2,
                bottom: 2,
                trailing: 2
            )
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    func makeContinueWatchingSectionLayout() -> NSCollectionLayoutSection {
        let item = makeItem(
            width: .fractionalWidth(1.0),
            height: .fractionalHeight(1.0),
            insets: NSDirectionalEdgeInsets(
                top: 10,
                leading: 5,
                bottom: 10,
                trailing: 8
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.8),
                heightDimension: .absolute(150)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = [makeSectionHeader()]
        
        return section
    }
    
    func makeNewReleasesSectionLayout() -> NSCollectionLayoutSection {
        let item = makeItem(
            width: .fractionalWidth(0.5),
            height: .fractionalHeight(1.0),
            insets: NSDirectionalEdgeInsets(
                top: 2,
                leading: 2,
                bottom: 2,
                trailing: 2
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)
            ),
            subitems: [item, item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [makeSectionHeader()]
        
        return section
    }
    
    func makeTrendingSectionLayout() -> NSCollectionLayoutSection {
        let item = makeItem(
            width: .fractionalWidth(1.0 / 3.0),
            height: .fractionalHeight(1.0),
            insets: NSDirectionalEdgeInsets(
                top: 10,
                leading: 5,
                bottom: 10,
                trailing: 8
            )
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(200)
            ),
            subitems: [item, item, item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [makeSectionHeader()]
        
        return section
    }
    
    func makePartnerHotelsSectionLayout() -> NSCollectionLayoutSection {
        let item = makeItem(
            width: .fractionalWidth(1.0),
            height: .fractionalHeight(1.0),
            insets: NSDirectionalEdgeInsets(
                top: 2,
                leading: 10,
                bottom: 2,
                trailing: 10
            )
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [makeSectionHeader()]
        
        return section
    }
    
    // MARK: - Layout Helpers
    
    func makeItem(
        width: NSCollectionLayoutDimension,
        height: NSCollectionLayoutDimension,
        insets: NSDirectionalEdgeInsets
    ) -> NSCollectionLayoutItem {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: width,
                heightDimension: height
            )
        )
        
        item.contentInsets = insets
        
        return item
    }
    
    func makeSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(50)
        )
        
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
    }
}
