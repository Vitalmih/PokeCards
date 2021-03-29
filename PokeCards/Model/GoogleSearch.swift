//
//  GoogleSearch.swift
//  PokeCards
//
//  Created by Виталий on 28.03.2021.
//

import Foundation


struct GoogleSearch: Codable {
    let kind: String
    let url: URLClass
    let queries: Queries
    let context: Context
    let searchInformation: SearchInformation
    let items: [Item]
}

// MARK: - Context
struct Context: Codable {
    let title: String
}

// MARK: - Item
struct Item: Codable {
    let kind, title, htmlTitle: String
    let link: String
    let displayLink, snippet, htmlSnippet, mime: String
    let fileFormat: String
    let image: Image
}

// MARK: - Image
struct Image: Codable {
    let contextLink: String
    let height, width, byteSize: Int
    let thumbnailLink: String
    let thumbnailHeight, thumbnailWidth: Int
}

// MARK: - Queries
struct Queries: Codable {
    let request: [Request]
}

// MARK: - Request
struct Request: Codable {
    let title, totalResults, searchTerms: String
    let count, startIndex: Int
    let inputEncoding, outputEncoding, safe, cx: String
    let fileType, searchType, imgSize: String
}

// MARK: - SearchInformation
struct SearchInformation: Codable {
    let searchTime: Double
    let formattedSearchTime, totalResults, formattedTotalResults: String
}

// MARK: - URLClass
struct URLClass: Codable {
    let type, template: String
}
