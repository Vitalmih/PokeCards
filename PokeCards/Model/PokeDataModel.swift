//
//  PokeDataModel.swift
//  PokeCards
//
//  Created by Виталий on 25.03.2021.
//

import Foundation

struct PokeDataModel: Codable {
    let count: Int
    let next: String
    let previous: String?
    let results: [Result]
}

struct Result: Codable {
    let name: String
    let url: String
}
