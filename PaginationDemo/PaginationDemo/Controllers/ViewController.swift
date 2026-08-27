//
//  ViewController.swift
//  PaginationDemo
//
//  Created by Rahul Acharya on 26/08/26.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    var listResults: [RMCharacter] = []
    
    
    // MARK: -  pagination var
    private var apiInfo: RMGetAllCharactersResponse.Info? = nil
    
    public var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
    
    private var isLoadinMoreCharacters = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listCollectionViewConfig()
        fetchCharacter()
    }
    
    // MARK: - methods
    
    func listCollectionViewConfig() {
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        listCollectionView.register(
            UINib(nibName: "CharacterCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "CharacterCollectionViewCell"
        )
        
        listCollectionView.register(
           UINib(nibName: "FooterCollectionReusableView", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: "FooterCollectionReusableView"
        )
    }
}

// MARK: -  API Call
extension ViewController {
    
    func fetchCharacter() {
        NetworkManager.shared.getData(
            RMGetAllCharactersResponse.self,
            url: "https://rickandmortyapi.com/api/character"
        ) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                self.listResults = success.results
                self.apiInfo = success.info
                DispatchQueue.main.async {
                    self.listCollectionView.reloadData()
                }
                self.isLoadinMoreCharacters = false
            case .failure:
                self.isLoadinMoreCharacters = false
                break
            }
        }
    }
    
    func fetchAdditionalCharacters(with url: String) {
        
        guard !isLoadinMoreCharacters else {
            return
        }
        isLoadinMoreCharacters = true
        print("TEST: API Call only first time")
        
        NetworkManager.shared.getData(
            RMGetAllCharactersResponse.self,
            url: url
        ) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                self.listResults.append(contentsOf: success.results)
                self.apiInfo = success.info
                DispatchQueue.main.async {
                    self.listCollectionView.reloadData()
                }
                self.isLoadinMoreCharacters = false
            case .failure:
                self.isLoadinMoreCharacters = false
                break
            }
        }
    }
}


// MARK: - CollectionView
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        listResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as? CharacterCollectionViewCell else {
            fatalError("Unsupported CharacterCollectionViewCell")
        }
        cell.setupConfig(with: listResults[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: (collectionView.bounds.size.width/2)-10,
            height: (collectionView.bounds.size.width/2)*1.5
        )
    }
}


// MARK: -  Pagination elementKindSectionFooter screen view
extension ViewController {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "FooterCollectionReusableView",
                for: indexPath
              ) as? FooterCollectionReusableView else {
            fatalError("Unsupported")
        }
        footer.vwBG.backgroundColor = .clear
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width,
                      height: 100)
    }
}

// MARK: - Pagination
extension ViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator,
              !isLoadinMoreCharacters,
              !listResults.isEmpty,
        let nextUrlString = apiInfo?.next  else {
            return
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            guard let self else { return }
            let offSet = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if offSet >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                self.fetchAdditionalCharacters(with: nextUrlString)
            }
            t.invalidate()
        }
    }
}
