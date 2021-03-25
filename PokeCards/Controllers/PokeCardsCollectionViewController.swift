//
//  PokeCardsCollectionViewController.swift
//  PokeCards
//
//  Created by Виталий on 25.03.2021.
//

import UIKit

class PokeCardsCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    //MARK: - Selectors
    @objc func handleShowSearchBar() {
        
    }
    
    //MARK: - Views
    private func setupViews() {
        configureNavibationsBar()
        collectionView.backgroundColor = .white
        collectionView.register(PokeCardCell.self, forCellWithReuseIdentifier: PokeCardCell.identifier )
    }
    
    //MARK: - Usefull Functions
    private func configureNavibationsBar() {
        
        let navigationBar = navigationController?.navigationBar
        navigationBar?.barTintColor = .systemIndigo
        navigationBar?.barStyle = .black
        navigationBar?.isTranslucent = false
        navigationBar?.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.title = "PokeCards"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
}

//MARK: - UICollectionViewDataSource
extension PokeCardsCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokeCardCell.identifier, for: indexPath) as! PokeCardCell
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PokeCardsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 16, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = (view.frame.width - 36) / 3
        return CGSize(width: size, height: size)
    }
}
