//
//  MovieDetailsViewController.swift
//  CollectionViewDemo
//
//  Created by Rahul Acharya on 03/11/26.
//

import UIKit

/// When use dynamic cell height like `Details` cell has 
class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    enum MovieDetailsSection: String, CaseIterable {
        case banner
        case details
        case casts
        case likes
        
        var title: String {
            switch self {
            case .banner:
                ""
            case .details:
                ""
            case .casts:
                "Main Cast"
            case .likes:
                "More Like This"
            }
        }
    }
    
    private(set) var sections: [MovieDetailsSection] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSections()
        collectionViewConfig()
    }
}
extension MovieDetailsViewController {
    func configureSections() {
        sections = [
            .banner,
            .details,
            .casts,
            .likes
        ]
    }
    
    func collectionViewConfig() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: "cell"
        )
        collectionView.register(
            MovieDetailsCollectionViewCell.self,
            forCellWithReuseIdentifier: "MovieDetailsCollectionViewCell"
        )
        // Register section header
        collectionView.register(
            UICollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "header"
        )
        
        collectionView.contentInsetAdjustmentBehavior = .never
        
        /// make collection view Layout
        collectionView.setCollectionViewLayout(
            makeCollectionViewLayout(),
            animated: false
        )
    }
}

extension MovieDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
        case .banner:
            return 1
        case .details:
            return 1
        case .casts:
            return 10
        case .likes:
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .banner:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .tertiarySystemBackground
            return cell
        case .details:
           guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "MovieDetailsCollectionViewCell",
                for: indexPath
           ) as? MovieDetailsCollectionViewCell else {
               fatalError()
           }
            cell.backgroundColor = .secondarySystemGroupedBackground
            return cell
        case .casts:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .secondarySystemFill
            return cell
        case .likes:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .secondarySystemBackground
            return cell
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            fatalError("Unsupported supplementary view kind: \(kind)")
        }
        
        let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "header",
            for: indexPath
        )
        headerView.backgroundColor = .systemGroupedBackground
        return headerView
    }
}

extension MovieDetailsViewController {
    
    func makeCollectionViewLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self,
                  sections.indices.contains(sectionIndex) else {
                return nil
            }

            return makeLayout(for: sections[sectionIndex])
        }
    }

    private func makeLayout(for section: MovieDetailsSection) -> NSCollectionLayoutSection {
        switch section {
        case .banner:
            return makeBannerSectionLayout()
        case .details:
            return makeDetailsSectionLayout()
        case .casts:
            return makeCastSectionLayout()
        case .likes:
            return makeLikesSectionLayout()
        }
    }

    // MARK: - Section Layouts

    private func makeBannerSectionLayout() -> NSCollectionLayoutSection {
        let item = makeItem(
            width: .fractionalWidth(1.0),
            height: .fractionalHeight(1.0),
            insets: NSDirectionalEdgeInsets(
                top: 0,
                leading: 0,
                bottom: 0,
                trailing: 0
            )
        )

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.55)
            ),
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func makeDetailsSectionLayout() -> NSCollectionLayoutSection {
        let item = makeItem(
            width: .fractionalWidth(1.0),
            height: .estimated(50),
            insets: NSDirectionalEdgeInsets(
                top: 0,
                leading: 0,
                bottom: 0,
                trailing: 0
            )
        )

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(50)
            ),
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        return section
    }

    private func makeCastSectionLayout() -> NSCollectionLayoutSection {
        let item = makeItem(
            width: .fractionalWidth(1.0),
            height: .fractionalHeight(1.0),
            insets: NSDirectionalEdgeInsets(
                top: 0,
                leading: 2,
                bottom: 0,
                trailing: 2
            )
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0/2),
                heightDimension: .fractionalWidth(1.0/2)
            ),
            subitems: [item, item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [makeSectionHeader()]

        return section
    }

    private func makeLikesSectionLayout() -> NSCollectionLayoutSection {
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
                heightDimension: .fractionalWidth(1.0*0.5)
            ),
            subitems: [item, item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [makeSectionHeader()]

        return section
    }


    // MARK: - Layout Helpers

    private func makeItem(
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

    private func makeSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
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
