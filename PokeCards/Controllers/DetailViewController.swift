//
//  DetailViewController.swift
//  PokeCards
//
//  Created by Виталий on 29.03.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    let pokemon: PokeDetails
    
    lazy var avatar: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .systemGray5
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let pokeName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pikachu"
        return label
    }()
    
    lazy var pokeNameContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemIndigo
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.addSubview(pokeName)
        view.addSubview(avatar)
        return view
    }()
    
    let baseExp: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Base exp:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let pokeHeight: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Height:"
        return label
    }()
    
    let pokeWeight: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Weight:"
        return label
    }()
    
    
    init(with pokemon: PokeDetails) {
        self.pokemon = pokemon
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureNavigationBar()
        configrueConstraints()
        fetchData()
        view.backgroundColor = .white
    }
    
    private func fetchData() {
        self.pokeName.text = pokemon.name.capitalized
        self.baseExp.text = "Base exp: \(pokemon.baseExperience)"
        self.pokeHeight.text = "Height: \(pokemon.height)"
        self.pokeWeight.text = "Weight: \(pokemon.weight)"
    }
    
    
    private func configrueConstraints() {
        
        pokeNameContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pokeNameContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        pokeNameContainerView.widthAnchor.constraint(equalToConstant: 128).isActive = true
        pokeNameContainerView.heightAnchor.constraint(equalToConstant: 128).isActive = true
        
        pokeName.bottomAnchor.constraint(equalTo: pokeNameContainerView.bottomAnchor, constant: -6).isActive = true
        pokeName.leftAnchor.constraint(equalTo: pokeNameContainerView.leftAnchor).isActive = true
        pokeName.rightAnchor.constraint(equalTo: pokeNameContainerView.rightAnchor).isActive = true
        
        avatar.heightAnchor.constraint(equalTo: pokeNameContainerView.heightAnchor, constant: pokeNameContainerView.frame.height - 32).isActive = true
        avatar.leftAnchor.constraint(equalTo: pokeNameContainerView.leftAnchor).isActive = true
        avatar.rightAnchor.constraint(equalTo: pokeNameContainerView.rightAnchor).isActive = true
        
        baseExp.topAnchor.constraint(equalTo: pokeNameContainerView.bottomAnchor, constant: 50).isActive = true
        baseExp.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        baseExp.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        pokeHeight.topAnchor.constraint(equalTo: baseExp.bottomAnchor, constant: 10).isActive = true
        pokeHeight.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        pokeHeight.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        pokeWeight.topAnchor.constraint(equalTo: pokeHeight.bottomAnchor, constant: 10).isActive = true
        pokeWeight.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        pokeWeight.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
    }
    
    private func addSubViews() {
        view.addSubview(avatar)
        view.addSubview(pokeNameContainerView)
        view.addSubview(baseExp)
        view.addSubview(pokeHeight)
        view.addSubview(pokeWeight)
    }
    
    private func configureNavigationBar() {
        let navigationBar = navigationController?.navigationBar
        navigationBar?.barTintColor = .systemIndigo
        navigationBar?.barStyle = .black
        navigationBar?.isTranslucent = false
        navigationBar?.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.title = "PokeDetails"
        navigationBar?.tintColor = .white
    }
}
