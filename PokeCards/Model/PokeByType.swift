//
//  PokeByType.swift
//  PokeCards
//
//  Created by Виталий on 28.03.2021.
//

import Foundation

struct PokeByType: Codable {
    
    let id: Int
    let name: String
    let names: [Name]
    let pokemon: [PokeWithType]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case names
        case  pokemon
    }
}

// MARK: - Generation
struct Generation: Codable {
    let name: String
    let url: String
}

// MARK: - Name
struct Name: Codable {
    let language: Generation
    let name: String
}

// MARK: - Pokemon
struct PokeWithType: Codable {
    let pokemon: Generation
    let slot: Int
}
