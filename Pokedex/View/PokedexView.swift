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
        ZStack {
            Color(hex: viewModel.backgroundColor)
            VStack {
                Text(viewModel.pokemonNumber)
                    .font(Font.title)
                    .foregroundColor(Color.white)
                if let pokemonImage = viewModel.pokemonImage {
                    Image(uiImage: pokemonImage)
                }
                Text(viewModel.pokemonName)
                    .font(Font.subheadline)
                    .foregroundColor(Color.white)
            }
        }.onAppear {
            viewModel.loadData()
        }.onTapGesture(count: 2) {
            viewModel.onViewDoubleTapped()
        }.onTapGesture {
            viewModel.onViewTapped()
        }
    }
}

struct PokedexView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexView()
    }
}
