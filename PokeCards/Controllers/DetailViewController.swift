//
//  DetailViewController.swift
//  PokeCards
//
//  Created by Виталий on 29.03.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    private let apiManager: PokeNetworkManagerProtocol
    private var detailString: String
    private var pokemon: PokeDetails?
    
    lazy var avatar: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .systemGray5
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var abilityOne: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.layer.cornerRadius = 10
        label.backgroundColor = .systemIndigo
        label.textColor = .white
        label.textAlignment = .left
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var abilityTwo: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.layer.cornerRadius = 10
        label.backgroundColor = .systemIndigo
        label.textColor = .white
        label.textAlignment = .left
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var pokeName: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
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
    
    var baseExp: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.layer.cornerRadius = 10
        label.backgroundColor = .systemIndigo
        label.textColor = .white
        label.textAlignment = .left
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var pokeHeight: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.layer.cornerRadius = 10
        label.backgroundColor = .systemIndigo
        label.textColor = .white
        label.textAlignment = .left
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var pokeWeight: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.layer.cornerRadius = 10
        label.backgroundColor = .systemIndigo
        label.textColor = .white
        label.textAlignment = .left
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    init(with pokemon: String, manager: APIManager) {
        self.apiManager = manager
        self.detailString = pokemon
        super.init(nibName: nil, bundle: nil)
        apiManager.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureNavigationBar()
        configrueConstraints()
        view.backgroundColor = .white
        apiManager.getPokeDetails(path: detailString)
    }
    
    private func configrueConstraints() {
        
        pokeNameContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pokeNameContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
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
        baseExp.heightAnchor.constraint(equalToConstant: 32).isActive = true
        baseExp.rightAnchor.constraint(equalTo: pokeNameContainerView.rightAnchor).isActive = true
        
        pokeHeight.topAnchor.constraint(equalTo: baseExp.bottomAnchor, constant: 10).isActive = true
        pokeHeight.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        pokeHeight.heightAnchor.constraint(equalToConstant: 32).isActive = true
        pokeHeight.rightAnchor.constraint(equalTo: pokeNameContainerView.rightAnchor).isActive = true
        
        pokeWeight.topAnchor.constraint(equalTo: pokeHeight.bottomAnchor, constant: 10).isActive = true
        pokeWeight.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        pokeWeight.heightAnchor.constraint(equalToConstant: 32).isActive = true
        pokeWeight.rightAnchor.constraint(equalTo: pokeNameContainerView.rightAnchor).isActive = true
        
        abilityOne.topAnchor.constraint(equalTo: pokeWeight.bottomAnchor, constant: 8).isActive = true
        abilityOne.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        abilityOne.heightAnchor.constraint(equalToConstant: 32).isActive = true
        abilityOne.rightAnchor.constraint(equalTo: pokeNameContainerView.rightAnchor).isActive = true
        
        abilityTwo.topAnchor.constraint(equalTo: abilityOne.bottomAnchor, constant: 8).isActive = true
        abilityTwo.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        abilityTwo.heightAnchor.constraint(equalToConstant: 32).isActive = true
        abilityTwo.rightAnchor.constraint(equalTo: pokeNameContainerView.rightAnchor).isActive = true
        
        stackView.topAnchor.constraint(equalTo: abilityTwo.bottomAnchor, constant: 16).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8).isActive = true
    }
    
    private func addSubViews() {
        view.addSubview(avatar)
        view.addSubview(pokeNameContainerView)
        view.addSubview(baseExp)
        view.addSubview(pokeHeight)
        view.addSubview(pokeWeight)
        view.addSubview(abilityOne)
        view.addSubview(abilityTwo)
        view.addSubview(stackView)
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

extension DetailViewController: PokeNetworkManagerDelegate {
    
    func didGetPokemonImage(item: GoogleSearch) {
        
    }
    
    func didGetPokemons(pokemons: PokeDataModel) {
        
    }
    
    func didGetPokeTypes(types: PokeTypes) {
        
    }
    
    func didGetPokeByType(type: PokeByType) {
        
    }
    
    func didGetPokeDetails(poke: PokeDetails) {
        self.pokeName.text = poke.name.capitalized
        self.baseExp.text = "Base exp: \(String(poke.baseExperience))"
        self.pokeHeight.text = "Height: \(String(poke.height))"
        self.pokeWeight.text = "Weight: \(String(poke.weight))"
        self.avatar.downloaded(from: poke.sprites.frontDefault)
        
        if let ability1 = poke.abilities.first?.ability.name {
            self.abilityOne.numberOfLines = 0
            self.abilityOne.text = "Ability 1: \(ability1.capitalized)"
        }
        
        if let ability2 = poke.abilities.last?.ability.name{
            self.abilityTwo.numberOfLines = 0
            self.abilityTwo.minimumScaleFactor = 0.3
            self.abilityTwo.text = "Ability 2: \(ability2.capitalized)"
        }
        
        if let backDefault = poke.sprites.backDefault {
            let image = UIImageView()
            image.contentMode = .scaleAspectFit
            image.clipsToBounds = true
            image.downloaded(from: backDefault)
            stackView.addArrangedSubview(image)
        }
        if let backFemale = poke.sprites.backFemale {
            let image = UIImageView()
            image.contentMode = .scaleAspectFit
            image.clipsToBounds = true
            image.downloaded(from: backFemale)
            stackView.addArrangedSubview(image)
        }
        if let backShiny = poke.sprites.backShiny {
            let image = UIImageView()
            image.contentMode = .scaleAspectFit
            image.clipsToBounds = true
            image.downloaded(from: backShiny)
            stackView.addArrangedSubview(image)
        }
        if  let backShinyFemale = poke.sprites.backShinyFemale {
            let image = UIImageView()
            image.contentMode = .scaleAspectFit
            image.clipsToBounds = true
            image.downloaded(from: backShinyFemale)
            stackView.addArrangedSubview(image)
        }
        if let frontFemale = poke.sprites.frontFemale {
            let image = UIImageView()
            image.contentMode = .scaleAspectFit
            image.clipsToBounds = true
            image.downloaded(from: frontFemale)
            stackView.addArrangedSubview(image)
        }
        if let frontShiny = poke.sprites.frontShiny {
            let image = UIImageView()
            image.contentMode = .scaleAspectFit
            image.clipsToBounds = true
            image.downloaded(from: frontShiny)
            stackView.addArrangedSubview(image)
        }
        
    }
    
    func didFailWithError(error: Error) {
        
    }
}
