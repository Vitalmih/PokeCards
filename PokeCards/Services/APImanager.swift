//
//  APImanager.swift
//  PokeCards
//
//  Created by Виталий on 25.03.2021.
//

import Foundation
import Alamofire

protocol PokeNetworkManagerProtocol: AnyObject {
    var delegate: PokeNetworkManagerDelegate? { get set }

    func getBasicPokemons()
    func getPokemons(path: String)
    func getGoogleImage(path: String)
    func getPokeByType(type: String)
    func getPokeDetails(path: String)
    func getTypes()
}

protocol PokeNetworkManagerDelegate {
    
    func didGetPokemonImage(item: GoogleSearch)
    func didGetPokemons(pokemons: PokeDataModel)
    func didGetPokeTypes(types: PokeTypes)
    func didGetPokeByType(type: PokeByType)
    func didGetPokeDetails(poke: PokeDetails)
    func didFailWithError(error: Error)
}

final class APIManager: PokeNetworkManagerProtocol {
    func getBasicPokemons() {
            let urlLink = "https://pokeapi.co/api/v2/pokemon?offset=0&limit=18"
            getPokemons(path: urlLink)
        }
    
    func getPokemons(path: String) {
        performRequest(with: path)
    }
    
    
    static let startUrlString = "https://pokeapi.co/api/v2/pokemon?offset=0&limit=18"
    
    var delegate: PokeNetworkManagerDelegate?
    var googleSearch = "https://www.googleapis.com/customsearch/v1?key=AIzaSyBb5bfsce9uIlZ0gD7Hqi1LRqMZue6A4GY&cx=a716d8c98e1ad584b&searchType=image&fileType=jpg&imgSize=xlarge&alt=json&start=0"
    var typeUrlString = "https://pokeapi.co/api/v2/type/"
    var detailUrlString = "https://pokeapi.co/api/v2/pokemon/"
    
    func getPokeDetails(path: String) {
        performRequestPokeDetails(with: path)
    }
    
    func getGoogleImage(path: String) {
        performRequestGoogle(with: path)
    }
    
    func getTypes() {
        performRequestTypes()
    }
    
    func getPokeByType(type: String) {
        performRequestPokeByType(with: type)
    }
    
    private func performRequest(with urlString: String) {
        AF.request(urlString, method: .get).responseJSON { response in
            switch response.result {
            case .success:
                let decoder = JSONDecoder()
                guard let data = response.data else { return }
                do {
                    let decodedData = try decoder.decode(PokeDataModel.self, from: data)
                    DispatchQueue.main.async {
                        self.delegate?.didGetPokemons(pokemons: decodedData)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.delegate?.didFailWithError(error: error)
                    }
                }
            case .failure(let error):
                self.delegate?.didFailWithError(error: error)
            }
        }
    }
    
    private func performRequestPokeByType(with type: String) {
        let urlString = "\(typeUrlString)\(type)"
        AF.request(urlString, method: .get).responseJSON { response in
            switch response.result {
            case .success:
                let decoder = JSONDecoder()
                guard let data = response.data else { return }
                do {
                    let decodedData = try decoder.decode(PokeByType.self, from: data)
                    DispatchQueue.main.async {
                        self.delegate?.didGetPokeByType(type: decodedData)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.delegate?.didFailWithError(error: error)
                    }
                }
            case .failure(let error):
                self.delegate?.didFailWithError(error: error)
            }
        }
    }
    
    private func performRequestGoogle(with search: String) {
        let searchWord = "\(googleSearch)&q=\(search)"
        print(searchWord)
        AF.request(searchWord, method: .get).responseJSON { response in
            switch response.result {
            case .success:
                let decoder = JSONDecoder()
                guard let data = response.data else { return }
                do {
                    let decodedData = try decoder.decode(GoogleSearch.self, from: data)
                    DispatchQueue.main.async {
                        self.delegate?.didGetPokemonImage(item: decodedData)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.delegate?.didFailWithError(error: error)
                    }
                }
            case .failure(let error):
                self.delegate?.didFailWithError(error: error)
            }
        }
    }
    
    private func performRequestTypes() {
        let allTypes = "https://pokeapi.co/api/v2/type"
        AF.request(allTypes, method: .get).responseJSON { response in
            switch response.result {
            case .success:
                let decoder = JSONDecoder()
                guard let data = response.data else { return }
                do {
                    let decodedData = try decoder.decode(PokeTypes.self, from: data)
                    DispatchQueue.main.async {
                        self.delegate?.didGetPokeTypes(types: decodedData)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.delegate?.didFailWithError(error: error)
                    }
                }
            case .failure(let error):
                self.delegate?.didFailWithError(error: error)
            }
        }
    }
    
    private func performRequestPokeDetails(with name: String) {
        let urlString = "\(detailUrlString)\(name)"
        AF.request(urlString, method: .get).responseJSON { response in
            switch response.result {
            case .success:
                let decoder = JSONDecoder()
                guard let data = response.data else { return }
                do {
                    let decodedData = try decoder.decode(PokeDetails.self, from: data)
                    DispatchQueue.main.async {
                        self.delegate?.didGetPokeDetails(poke: decodedData)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.delegate?.didFailWithError(error: error)
                    }
                }
            case .failure(let error):
                self.delegate?.didFailWithError(error: error)
            }
        }
    }
}
