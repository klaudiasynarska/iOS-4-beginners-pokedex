//
//  PokedexViewModel.swift
//  Pokedex
//
//  Created by Klaudia Synarska on 11/12/2021.
//

import Foundation

class PokedexViewModel: ObservableObject {
    
    init(pokemonAPI: PokemonAPI) {
        self.pokemonAPI = pokemonAPI
    }

    var pokemonNumber: String {
        return ""
    }
    
    var pokemonName: String {
        return ""
    }
    
    var pokemonImageURL: URL? {
        return nil
    }
    
    private let pokemonAPI: PokemonAPI
}
