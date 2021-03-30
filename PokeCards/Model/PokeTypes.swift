//
//  PokeTypes.swift
//  PokeCards
//
//  Created by Виталий on 28.03.2021.
//

import Foundation

struct PokeTypes: Codable {
    let count: Int
    let results: [Type]
}

struct Type: Codable {
    let name: String
    let url: String
}

