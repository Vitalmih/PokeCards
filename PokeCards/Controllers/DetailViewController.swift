//
//  DetailViewController.swift
//  PokeCards
//
//  Created by Виталий on 29.03.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
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
        view.addSubview(pokeName)
        view.addSubview(avatar)
        return view
    }()
    
    let baseExp: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let pokeHeight: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let pokeWeight: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureNavigationBar()
        configrueConstraints()
        view.backgroundColor = .white
    }
    
    private func configrueConstraints() {
//        avatar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        avatar.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
//        avatar.widthAnchor.constraint(equalToConstant: 128).isActive = true
//        avatar.heightAnchor.constraint(equalToConstant: 128).isActive = true
        
        pokeNameContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pokeNameContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        pokeNameContainerView.widthAnchor.constraint(equalToConstant: 128).isActive = true
        pokeNameContainerView.heightAnchor.constraint(equalToConstant: 128).isActive = true
        
        pokeName.bottomAnchor.constraint(equalTo: pokeNameContainerView.bottomAnchor, constant: -6).isActive = true
        pokeName.leftAnchor.constraint(equalTo: pokeNameContainerView.leftAnchor).isActive = true
        pokeName.rightAnchor.constraint(equalTo: pokeNameContainerView.rightAnchor).isActive = true
        
        
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
