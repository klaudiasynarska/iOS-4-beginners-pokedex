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
    
    var pokemonName: String {
        guard let pokemon = pokemonManager.pokemon else { return "" }
        return pokemon.name
    }
    
    var backgroundColor: Int {
        guard let pokemon = pokemonManager.pokemon else { return 0 }
        return pokemon.color
    }
    
    var pokemonImage: UIImage? {
        return pokemonManager.pokemonImage
    }
    
    @Published var errorMessage: String? { didSet { isShowingError = errorMessage != nil } }
    @Published var isLoading: Bool = false
    @Published var isShowingError: Bool = false
    
    private let pokemonManager: PokemonManager
    private var task: Task<(), Never>?
    
    func hideError() {
        errorMessage = nil
    }
    
    func loadData() {
        makeAction(pokemonManager.loadCurrentPokemon)
    }
    
    func onViewTapped() {
        makeAction(pokemonManager.loadNextPokemon)
    }
    
    func onViewDoubleTapped() {
        makeAction(pokemonManager.loadPreviousPokemon)
    }
    
    func onViewDragged() {
        makeAction(pokemonManager.catchPokemon)
    }
    
    private func makeAction(_ action: @escaping () async throws -> Void) {
        task = Task {
            isLoading = true
            do {
                try await action()
                
                withAnimation {
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
