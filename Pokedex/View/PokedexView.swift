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
        }
        .onAppear {
            viewModel.loadData()
        }.onTapGesture(count: 2) {
            viewModel.onViewDoubleTapped()
        }.onTapGesture {
            viewModel.onViewTapped()
        }.gesture(dragGesture)
        .alert(
            viewModel.errorMessage ?? "",
            isPresented: $viewModel.isShowingError,
            actions: {
                Button(action: { viewModel.hideError() }) {
                    Text("OK")
                        .foregroundColor(.white)
                        .frame(width: 200, height: 40)
                }
                .buttonStyle(.borderedProminent)
            }
        )
        .overlay(loadingOverlay)
        
    }
    
    @ViewBuilder
    private var loadingOverlay: some View {
        if viewModel.isLoading {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .padding(30)
                .background(Color.black.blur(radius: 20))
                .mask(RoundedRectangle(cornerRadius: 8))
        }
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
