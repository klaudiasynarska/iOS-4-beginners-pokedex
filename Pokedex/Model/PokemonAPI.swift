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

enum SwitterAPIError: Error {
    case invalidURL
    case invalidData
}

class SwitterAPI: PokemonAPI {
    
    private static let baseURL: String = "https://switter.app.daftmobile.com"
    
    func fetchPokemon(number: Int) async throws -> Pokemon {
        guard let url = URL(string: SwitterAPI.baseURL + "/api/pokemon/\(number)") else {
            throw SwitterAPIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        let deviceUuid = await UIDevice.current.identifierForVendor?.uuidString ?? ""
        request.addValue(deviceUuid, forHTTPHeaderField: "x-device-uuid")

        let (data, _) = try await URLSession.shared.data(for: request, delegate: nil)
        
        guard let pokemon = try? JSONDecoder().decode(Pokemon.self, from: data) else {
            throw SwitterAPIError.invalidData
        }

        return pokemon
    }
    
    func fetchPokemonImage(number: Int) async throws -> UIImage {
        guard let url = URL(string: SwitterAPI.baseURL + "/api/pokemon/\(number)/image") else {
            throw SwitterAPIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        let deviceUuid = await UIDevice.current.identifierForVendor?.uuidString ?? ""
        request.addValue(deviceUuid, forHTTPHeaderField: "x-device-uuid")

        let (data, _) = try await URLSession.shared.data(for: request, delegate: nil)
        
        guard let image = UIImage(data: data) else {
            throw SwitterAPIError.invalidData
        }

        return image
    }
    
    func catchPokemon(number: Int) async throws -> Pokemon {
        guard let url = URL(string: SwitterAPI.baseURL + "/api/pokemon/\(number)/catch") else {
            throw SwitterAPIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        let deviceUuid = await UIDevice.current.identifierForVendor?.uuidString ?? ""
        request.addValue(deviceUuid, forHTTPHeaderField: "x-device-uuid")
        request.httpMethod = "POST"

        let (data, _) = try await URLSession.shared.data(for: request, delegate: nil)
        
        guard let pokemon = try? JSONDecoder().decode(Pokemon.self, from: data) else {
            throw SwitterAPIError.invalidData
        }

        return pokemon
    }
}
