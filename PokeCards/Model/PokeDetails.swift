//
//  Pokemons.swift
//  PokeCards
//
//  Created by Виталий on 26.03.2021.
//

import Foundation

// MARK: - Pokemon
struct PokeDetails: Codable {
    let abilities: [AbilityElements]
    let baseExperience: Int
    let height: Int
    let name: String
    let sprites: Sprites
    let weight: Int
    
    enum CodingKeys: String, CodingKey {
        case abilities
        case baseExperience = "base_experience"
        case height
        case name
        case sprites, weight
    }
}

// MARK: - Ability
struct AbilityElements: Codable {
    let ability: Ability
    
    enum CodingKeys: String, CodingKey {
        case ability
    }
}

struct Ability: Codable {
    let name: String
    let url: String
}

// MARK: - Sprites
struct Sprites: Codable {
    let backDefault: String?
    let backFemale: String?
    let backShiny: String?
    let backShinyFemale: String?
    let frontDefault: String
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?
    
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backFemale = "back_female"
        case backShiny = "back_shiny"
        case backShinyFemale = "back_shiny_female"
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }
}
