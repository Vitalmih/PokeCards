//
//  TypesViewController.swift
//  PokeCards
//
//  Created by Виталий on 28.03.2021.
//

import UIKit

class TypesViewController: UIViewController {
    
    var pokeTypes: [PokeTypes]
    var array = [Type]()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PokeTypesCell.self, forCellReuseIdentifier: PokeTypesCell.identifier)
        tableView.backgroundColor = .white
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
    }
    
    private func configureConstraints() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func showType(type: String) {
        let manager = APIManager()
        let vc = PokeCardsCollectionViewController(apiManager: manager)
        vc.apiManager.getPokeByType(type: type)
    }
}

extension TypesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokeTypesCell.identifier, for: indexPath) as! PokeTypesCell
        let type = array[indexPath.row]
        cell.textLabel?.text = type.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        showType(type: cell?.textLabel?.text ?? "")
    }
}
