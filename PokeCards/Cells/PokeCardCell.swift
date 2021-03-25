//
//  PokeCardCell.swift
//  PokeCards
//
//  Created by Виталий on 25.03.2021.
//

import UIKit

class PokeCardCell: UICollectionViewCell {
    
    static let identifier = "PokeCardCell"
    
    var pokeImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .systemGray5
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Pikachu"
        return label
    }()
    
    lazy var pokeNamecontainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemIndigo
        view.addSubview(nameLabel)
        nameLabel.center(inView: view)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(pokeImage)
        addSubview(pokeNamecontainerView)
    }
    
    private func setupConstraints() {
        pokeNamecontainerView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 32)
        pokeImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: self.frame.height - 32)
    }
    
    private func configureCell() {
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        addSubviews()
        setupConstraints()
    }
}
