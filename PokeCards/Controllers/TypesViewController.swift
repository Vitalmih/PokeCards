//
//  TypesViewController.swift
//  PokeCards
//
//  Created by Виталий on 28.03.2021.
//

import UIKit

protocol TypesViewControllerDelegate: class {
    
    func didSelect(type: String)
    func showAllPokemons(clean: [PokeWithType])
}

class TypesViewController: UIViewController {
    
    var pokeTypes: [PokeTypes]
    var array = [Type]()
    
    weak var delegate: TypesViewControllerDelegate?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PokeTypesCell.self, forCellReuseIdentifier: PokeTypesCell.identifier)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(with types: [PokeTypes]) {
        self.pokeTypes = types
        super.init(nibName: nil, bundle: nil)
        pokeTypes.forEach { type in
            array = type.results
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        configureConstraints()
        configureNavigationBar()
    }
    
    //MARK: - Selectors
    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func showAll() {
        self.delegate?.showAllPokemons(clean: [])
        self.dismiss(animated: true, completion: nil)
    }
    
    private func configureNavigationBar() {
        let navigationBar = navigationController?.navigationBar
        navigationBar?.barTintColor = .systemIndigo
        navigationBar?.barStyle = .black
        navigationBar?.isTranslucent = false
        navigationBar?.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.title = "PokeTypes"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(showAll))
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem?.tintColor = .white

    }
    
    private func configureConstraints() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension TypesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokeTypesCell.identifier, for: indexPath) as! PokeTypesCell
        let type = array[indexPath.row]
        cell.textLabel?.text = type.name.capitalized
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = array[indexPath.row]
        self.delegate?.didSelect(type: type.name)
        self.dismiss(animated: true, completion: nil)
    }
}
