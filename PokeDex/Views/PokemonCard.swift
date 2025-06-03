//
//  PokemonCard.swift
//  PokeDex
//
//  Created by Adriano Valumin on 20/05/25.
//

import SwiftUI

struct PokemonCard: View {
    var pokemon: Pokemon

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text(pokemon.data.name.capitalized)
                    .font(.title)
                    .background {
                        RoundedRectangle(cornerRadius: 9)
                            .frame(width: .infinity, height: .infinity)
                            .padding(-5)
                            .foregroundStyle(.white)
                    }
                    .padding()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .background(
            AsyncImage(url: pokemon.cover.image)
//                .offset(x: 0, y: 100)
        )
        .cornerRadius(16)
    }
}

#Preview {
    PokemonCard(
        pokemon: .init(data: .init(name: "Pikachu"), cover: .init(indexImage: 16))
    )
}
