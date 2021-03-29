//
//  PokeCardsCollectionViewController.swift
//  PokeCards
//
//  Created by Виталий on 25.03.2021.
//

import UIKit

class PokeCardsCollectionViewController: UIViewController {
    
    let apiManager: PokeNetworkManagerProtocol
    var pokeNames = [Result]()
    var pokeTypes = [PokeTypes]()
    var nextPage = ""
  
//    let api = "AIzaSyBb5bfsce9uIlZ0gD7Hqi1LRqMZue6A4GY"
//    let cx = "d930cfdefb8533272"
    var pokeImageLink = ""
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PokeCardCell.self, forCellWithReuseIdentifier: PokeCardCell.identifier)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureNavibationsBar()
        configureConstraints()
        apiManager.getRepositories(path: APIManager.startUrlString)
        apiManager.getTypes()
    }
    
    //MARK: - Init
    init(apiManager: PokeNetworkManagerProtocol) {
        self.apiManager = apiManager
        super.init(nibName: nil, bundle: nil)
        apiManager.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    @objc func handleShowSearchBar() {
        
    }
    
    @objc func showTypes() {
        showDetails(with: pokeTypes)
    }
    
    //MARK: - Functions
    
    private func configureNavibationsBar() {
        let navigationBar = navigationController?.navigationBar
        navigationBar?.barTintColor = .systemIndigo
        navigationBar?.barStyle = .black
        navigationBar?.isTranslucent = false
        navigationBar?.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.title = "PokeCards"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(showTypes))
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    private func configureConstraints() {
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func addSubViews() {
        view.addSubview(collectionView)
    }
    
    private func showAlert(title: String, buttonTitle: String, error: Error) {
        let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showDetails(with types: [PokeTypes]) {
        let typeVC = TypesViewController(with: types)
        let nv = UINavigationController(rootViewController: typeVC)
        typeVC.tableView.reloadData()
        nv.modalPresentationStyle = .fullScreen
        present(nv, animated: true, completion: nil)
    }
}

//MARK: - UICollectionViewDataSource
extension PokeCardsCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokeNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokeCardCell.identifier, for: indexPath) as! PokeCardCell
        
        let poke = pokeNames[indexPath.row]
        cell.nameLabel.text = poke.name
        cell.pokeImage.downloaded(from: pokeImageLink)
        return cell
    }
}

extension PokeCardsCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == pokeNames.count - 3 && nextPage != "" {
            apiManager.getRepositories(path: nextPage)
        }
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

extension PokeCardsCollectionViewController: PokeNetworkManagerDelegate {
    
    func didGetPokeByType(type: PokeByType) {
        print(type.pokemon)
    }
    
    func didGetPokeTypes(types: PokeTypes) {
        self.pokeTypes.append(types)
        
    }
    
    func didGetPokemonImage(item: GoogleSearch) {

        let link = item.items.first
        pokeImageLink = link?.link ?? ""
    }
    
    func didGetPokemons(pokemons: PokeDataModel) {
        self.pokeNames.append(contentsOf: pokemons.results)
        self.nextPage = pokemons.next
        collectionView.reloadData()
    }
    
    func didFailWithError(error: Error) {
        showAlert(title: "Error", buttonTitle: "Ok", error: error)
    }
}
