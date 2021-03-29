//
//  PokeTypes.swift
//  PokeCards
//
//  Created by Виталий on 28.03.2021.
//

import Foundation

// MARK: - PokeDataModel
struct PokeTypes: Codable {
    let count: Int
//    let next, previous: JSONNull?
    let results: [Type]
}

// MARK: - Result
struct Type: Codable {
    let name: String
    let url: String
}

// MARK: - Encode/decode helpers

//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
