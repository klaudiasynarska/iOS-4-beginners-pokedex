//
//  PokemonManager.swift
//  Pokedex
//
//  Created by Klaudia Synarska on 11/12/2021.
//

import Foundation

protocol PokemonManager {
    var pokemon: Pokemon? { get }
    func loadCurrentPokemon() async throws
    func loadNextPokemon() async throws
    func loadPreviousPokemon() async throws
}

class PokemonManagerDefault: PokemonManager {
    
    init(pokemonAPI: PokemonAPI = SwitterAPI()) {
        self.pokemonAPI = pokemonAPI
    }
    
    var pokemon: Pokemon?
    
    private var pokemonNumber: Int = 1
    
    private let pokemonAPI: PokemonAPI
    
    func loadCurrentPokemon() async throws {
        pokemon = try await pokemonAPI.fetchPokemon(number: pokemonNumber)
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
}
