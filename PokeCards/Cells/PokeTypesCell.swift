//
//  PokeTypesCell.swift
//  PokeCards
//
//  Created by Виталий on 28.03.2021.
//

import UIKit

class PokeTypesCell: UITableViewCell {

    static let identifier = "PokeTypesCell"
    let typeName = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(typeName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(name: String) {
        self.typeName.text = name
    }
}
