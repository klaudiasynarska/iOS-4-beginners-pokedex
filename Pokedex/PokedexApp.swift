//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Klaudia Synarska on 11/12/2021.
//

import SwiftUI

@main
struct PokedexApp: App {
    
    let viewModel = PokedexViewModel(pokemonAPI: SwitterAPI())
    
    var body: some Scene {
        WindowGroup {
            PokedexView()
                .environmentObject(viewModel)
        }
    }
}
