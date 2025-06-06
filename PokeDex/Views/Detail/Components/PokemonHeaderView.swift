//
//  PokemonHeaderView.swift
//  PokeDex
//
//  Created by Adriano Valumin on 05/06/25.
//

import SwiftUI

struct PokemonHeaderView: View {
    let pokemon: Pokemon
    let backgroundColor: Color

    var body: some View {
        VStack(spacing: 16) {
            AsyncImage(url: pokemon.cover.image) { image in
                image.image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .frame(width: 200, height: 200)
            .background(
                Circle()
                    .fill(backgroundColor.opacity(0.2))
                    .shadow(color: backgroundColor.opacity(0.3), radius: 10, x: 0, y: 5)
            )

            Text(pokemon.data.name.capitalized)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
        }
        .padding(.top)
    }
}

#Preview {
    PokemonHeaderView(
        pokemon: Pokemon(
            data: PokemonDTO(name: "pikachu"),
            cover: PokemonCover(indexImage: 25)
        ),
        backgroundColor: .yellow
    )
}
