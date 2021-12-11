//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by Klaudia Synarska on 11/12/2021.
//

import Foundation
import UIKit

protocol PokemonAPI {
    func fetchPokemon(number: Int) async throws -> Pokemon
    func catchPokemon(number: Int) async throws -> Pokemon
    func fetchPokemonImage(number: Int) async throws -> UIImage
}

enum SwitterAPIError: LocalizedError {
    case invalidURL
    case invalidData

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Wrong URL"
        case .invalidData:
            return "Failed to load data"
        }
    }
}

class SwitterAPI: PokemonAPI {
    
    private static let baseURL: String = "https://switter.app.daftmobile.com"
    
    func fetchPokemon(number: Int) async throws -> Pokemon {
        let path = "/api/pokemon/\(number)"
        let request = try await createRequest(path: path)

        let (data, _) = try await URLSession.shared.data(for: request, delegate: nil)
        
        guard let pokemon = try? JSONDecoder().decode(Pokemon.self, from: data) else {
            throw SwitterAPIError.invalidData
        }

        return pokemon
    }
    
    func fetchPokemonImage(number: Int) async throws -> UIImage {
        let path = "/api/pokemon/\(number)/image"
        let request = try await createRequest(path: path)
        let (data, _) = try await URLSession.shared.data(for: request, delegate: nil)
        
        guard let image = UIImage(data: data) else {
            throw SwitterAPIError.invalidData
        }

        return image
    }
    
    func catchPokemon(number: Int) async throws -> Pokemon {
        let path = "/api/pokemon/\(number)/catch"
        var request = try await createRequest(path: path)
        request.httpMethod = "POST"

        let (data, _) = try await URLSession.shared.data(for: request, delegate: nil)
        
        guard let pokemon = try? JSONDecoder().decode(Pokemon.self, from: data) else {
            throw SwitterAPIError.invalidData
        }

        return pokemon
    }
    
    private func createRequest(path: String) async throws -> URLRequest {
        guard let url = URL(string: SwitterAPI.baseURL + path) else {
            throw SwitterAPIError.invalidURL
        }
        var request = URLRequest(url: url)
        let deviceUuid = await UIDevice.current.identifierForVendor?.uuidString ?? ""
        request.addValue(deviceUuid, forHTTPHeaderField: "x-device-uuid")
        return request
    }
}
