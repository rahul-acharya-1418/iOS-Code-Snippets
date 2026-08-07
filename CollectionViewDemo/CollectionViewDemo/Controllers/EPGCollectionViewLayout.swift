//
//  EPGCollectionViewLayout.swift
//  CollectionViewDemo
//
//  Created by Rahul Acharya on 07/08/26.
//

import UIKit

class EPGCollectionViewLayout: UICollectionViewLayout {

    let cellWidth: CGFloat = 120
    let cellHeight: CGFloat = 120

    let totalSections = 30
    let totalItems = 30

    private var attributes: [IndexPath: UICollectionViewLayoutAttributes] = [:]
    private var contentSize: CGSize = .zero
    private var needsRebuild = true

    override var collectionViewContentSize: CGSize {
        contentSize
    }

    override func prepare() {

        guard let collectionView = collectionView else { return }

        if !needsRebuild {

            let xOffset = collectionView.contentOffset.x
            let yOffset = collectionView.contentOffset.y

            for (indexPath, attribute) in attributes {

                var frame = attribute.frame

                if indexPath.section == 0 {
                    frame.origin.y = yOffset
                }

                if indexPath.item == 0 {
                    frame.origin.x = xOffset
                }

                attribute.frame = frame
            }

            return
        }

        needsRebuild = false
        attributes.removeAll()

        for section in 0..<totalSections {

            for item in 0..<totalItems {

                let indexPath = IndexPath(item: item, section: section)

                let frame = CGRect(
                    x: CGFloat(item) * cellWidth,
                    y: CGFloat(section) * cellHeight,
                    width: cellWidth,
                    height: cellHeight
                )

                let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attr.frame = frame

                if section == 0 && item == 0 {
                    attr.zIndex = 4
                } else if section == 0 {
                    attr.zIndex = 3
                } else if item == 0 {
                    attr.zIndex = 2
                } else {
                    attr.zIndex = 1
                }

                attributes[indexPath] = attr
            }
        }

        contentSize = CGSize(
            width: CGFloat(totalItems) * cellWidth,
            height: CGFloat(totalSections) * cellHeight
        )
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        attributes.values.filter {
            $0.frame.intersects(rect)
        }
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        attributes[indexPath]
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }

    func reloadLayout() {
        needsRebuild = true
    }
}
