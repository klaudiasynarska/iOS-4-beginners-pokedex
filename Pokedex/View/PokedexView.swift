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
                .edgesIgnoringSafeArea(.all)
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
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
            }
        }.onAppear {
            viewModel.loadData()
        }.onTapGesture(count: 2) {
            viewModel.onViewDoubleTapped()
        }.onTapGesture {
            viewModel.onViewTapped()
        }.gesture(dragGesture)
    }
    
    private var dragGesture: some Gesture {
        DragGesture()
            .onEnded { _ in self.viewModel.onViewDragged() }
    }
}

struct PokedexView_Previews: PreviewProvider {
    static var previews: some View {
        PokedexView()
    }
}
