//
//  PokeCardsCollectionViewController.swift
//  PokeCards
//
//  Created by Виталий on 25.03.2021.
//

import UIKit

class PokeCardsCollectionViewController: UIViewController {
    
    private let apiManager: PokeNetworkManagerProtocol
    private var pokeNames = [Result]()
    private var pokeTypes = [PokeTypes]()
    private var filtredPokeNames = [PokeWithType]()
    private var nextPage = ""
    
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
        apiManager.getBasicPokemons()
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
    @objc func showTypes() {
        showTypesVC(with: pokeTypes)
    }
    
    @objc func addPoke() {
        
    }
    
    //MARK: - Functions
    private func configureNavibationsBar() {
        let navigationBar = navigationController?.navigationBar
        navigationBar?.barTintColor = .systemIndigo
        navigationBar?.barStyle = .black
        navigationBar?.isTranslucent = false
        navigationBar?.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.title = "PokeCards"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPoke))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(showTypes))
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem?.tintColor = .white
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
    
    private func showTypesVC(with types: [PokeTypes]) {
        let typeVC = TypesViewController(with: types)
        typeVC.delegate = self
        let nv = UINavigationController(rootViewController: typeVC)
        nv.modalPresentationStyle = .fullScreen
        present(nv, animated: true, completion: nil)
    }
    
    private func showDetailVC() {
        let detailVC = DetailViewController()
        let nv = UINavigationController(rootViewController: detailVC)
        nv.modalPresentationStyle = .fullScreen
        nv.navigationBar.tintColor = .white
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

//MARK: - UICollectionViewDataSource
extension PokeCardsCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if filtredPokeNames.isEmpty {
            return pokeNames.count
        } else {
            return filtredPokeNames.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokeCardCell.identifier, for: indexPath) as! PokeCardCell
        if filtredPokeNames.isEmpty {
            let poke = pokeNames[indexPath.row]
            cell.nameLabel.text = poke.name.capitalized
//            apiManager.getGoogleImage(path: poke.name)
//            cell.pokeImage.downloaded(from: pokeImageLink)
        } else {
            let poke = filtredPokeNames[indexPath.row]
            cell.nameLabel.text = poke.pokemon.name.capitalized
        }
        return cell
    }
}

extension PokeCardsCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == pokeNames.count - 3 && nextPage != "" {
            apiManager.getPokemons(path: nextPage)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        apiManager.getPokeDetails(path: "bulbasaur")
        showDetailVC()
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
    
    func didGetPokeDetails(poke: PokeDetails) {
    
        print(poke.abilities)
    }
    
    func didGetPokeByType(type: PokeByType) {
        self.filtredPokeNames.append(contentsOf: type.pokemon)
        collectionView.reloadData()
    }
    
    func didGetPokeTypes(types: PokeTypes) {
        self.pokeTypes.append(types)
        collectionView.reloadData()
    }
    
    func didGetPokemonImage(item: GoogleSearch) {
        
//        item.items?.compactMap {item in
//            print (item.link)
//            pokeImageLink = item.link
//        }
    }
    
    func didGetPokemons(pokemons: PokeDataModel) {
        self.pokeNames.append(contentsOf: pokemons.results)
        self.nextPage = pokemons.next ?? ""
        collectionView.reloadData()
    }
    
    func didFailWithError(error: Error) {
        showAlert(title: "Error", buttonTitle: "Ok", error: error)
    }
}

extension PokeCardsCollectionViewController: TypesViewControllerDelegate {
    
    func didSelect(type: String) {
        apiManager.getPokeByType(type: type)
        filtredPokeNames = []
    }
}
