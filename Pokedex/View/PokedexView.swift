//
//  PokedexView.swift
//  Pokedex
//
//  Created by Klaudia Synarska on 11/12/2021.
//

import SwiftUI

struct PokedexView: View {
    
    @EnvironmentObject var viewModel: PokedexViewModel

    var body: some View {
        VStack {
            Text(viewModel.pokemonNumber)
                .padding()
            Text(viewModel.pokemonName)
                .padding()
            Text(viewModel.pokemonImageURL?.description ?? "")
                .padding()
        }.onAppear {
            viewModel.loadData()
        }
    }
}

struct PokedexView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexView()
    }
}
