//
//  PokedexViewModel.swift
//  Pokedex
//
//  Created by Klaudia Synarska on 11/12/2021.
//

import SwiftUI

@MainActor
class PokedexViewModel: ObservableObject {
    
    init(pokemonManager: PokemonManager) {
        self.pokemonManager = pokemonManager
    }

    var pokemonNumber: String {
        guard let pokemon = pokemonManager.pokemon else { return "" }
        return String(pokemon.number)
    }
    
    @Published var pokemonName: String = ""
    @Published var pokemonImageURL: URL?
    @Published var errorMessage: String? { didSet { isShowingError = errorMessage != nil } }
    @Published var isLoading: Bool = false
    @Published var isShowingError: Bool = false
    
    private let pokemonManager: PokemonManager
    private var task: Task<(), Never>?
    
    func loadData() {
        task = Task {
            isLoading = true
            do {
                try await pokemonManager.loadCurrentPokemon()
                
                withAnimation {
//                    guard let pokemon = pokemonManager.pokemon else { return }
                    self.objectWillChange.send()
                }

            } catch let error {
                print(error)
                self.errorMessage = error.localizedDescription
            }
            
            isLoading = false
        }
    }
}
