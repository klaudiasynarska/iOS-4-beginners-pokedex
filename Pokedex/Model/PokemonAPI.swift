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
}
