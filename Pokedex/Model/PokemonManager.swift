//
//  PokemonManager.swift
//  Pokedex
//
//  Created by Klaudia Synarska on 11/12/2021.
//

import Foundation
import UIKit

protocol PokemonManager {
    var pokemon: Pokemon? { get }
    var pokemonImage: UIImage? { get }
    func loadCurrentPokemon() async throws
    func loadNextPokemon() async throws
    func loadPreviousPokemon() async throws
    func catchPokemon() async throws
}

class PokemonManagerDefault: PokemonManager {
    
    init(pokemonAPI: PokemonAPI = SwitterAPI()) {
        self.pokemonAPI = pokemonAPI
    }
    
    var pokemon: Pokemon?
    var pokemonImage: UIImage?
    
    private var pokemonNumber: Int = 1
    
    private let pokemonAPI: PokemonAPI
    
    func loadCurrentPokemon() async throws {
        pokemon = try await pokemonAPI.fetchPokemon(number: pokemonNumber)
        pokemonImage = try await pokemonAPI.fetchPokemonImage(number: pokemonNumber)
    }
    
    func loadNextPokemon() async throws {
        pokemonNumber += 1
        try await loadCurrentPokemon()
    }
    
    func loadPreviousPokemon() async throws {
        guard pokemonNumber > 1 else { return }
        pokemonNumber -= 1
        try await loadCurrentPokemon()
    }
    
    func catchPokemon() async throws {
        pokemon = try await pokemonAPI.catchPokemon(number: pokemonNumber)
        pokemonImage = try await pokemonAPI.fetchPokemonImage(number: pokemonNumber)
    }
}
