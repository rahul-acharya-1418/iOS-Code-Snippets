//
//  EPGViewController.swift
//  CollectionViewDemo
//
//  Created by Rahul Acharya on 07/08/26.
//

import UIKit

class EPGViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = EPGCollectionViewLayout()
        collectionView.register(ProgramCollectionViewCell.self,
                                forCellWithReuseIdentifier: ProgramCollectionViewCell.cellIdentifier)
        collectionView.register(ChannelCollectionViewCell.self,
                                forCellWithReuseIdentifier: ChannelCollectionViewCell.cellIdentifier)
        collectionView.register(TimeCollectionViewCell.self,
                                forCellWithReuseIdentifier: TimeCollectionViewCell.cellIdentifier)
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension EPGViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        30
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        /// time cell
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeCollectionViewCell.cellIdentifier, for: indexPath) as?  TimeCollectionViewCell else {
                fatalError("Unsupport")
            }
            return cell
        }
        
        /// channel cell
        if indexPath.item == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChannelCollectionViewCell.cellIdentifier, for: indexPath) as?  ChannelCollectionViewCell else {
                fatalError("Unsupport")
            }
            return cell
        }
     
        /// program cell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgramCollectionViewCell.cellIdentifier, for: indexPath) as?  ProgramCollectionViewCell else {
            fatalError("Unsupport")
        }
        return cell
    }
}
