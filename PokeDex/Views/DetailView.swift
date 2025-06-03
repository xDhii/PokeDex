//
//  DetailView.swift
//  PokeDex
//
//  Created by Adriano Valumin on 20/05/25.
//

import SwiftUI

struct DetailView: View {
    var pokemon: Pokemon
    @State var detail: PokemonDetail?
    @State var backgroundColorPokemonType: Color = .gray

    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: pokemon.cover.image) { image in
                    image.image?.resizable()
                }
                .padding(12)
                .background(backgroundColorPokemonType)
                .frame(width: 120, height: 120)
                .clipShape(.circle)
                VStack(alignment: .leading) {
                    Text(pokemon.data.name)
                    HStack {
                        if let detail {
                            ForEach(Array(detail.types)) { detail in
                                Text(String(detail.name).capitalized)
                            }
                        }
                    }
                }

                Spacer()
            }

            Spacer()
        }
        .padding(16)
        .onAppear {
            Task {
                do {
                    let pokemonDetail = try await Network.shared.fetchDetail(name: pokemon.data.name)
                    let types = pokemonDetail.types.map { detail in
                        PokemonDetailTypes(name: detail.type.name)
                    }
                    detail = PokemonDetail(types: types)

                    if let firstType = types.first {
                        backgroundColorPokemonType = checkBackgroundColor(type: firstType.name)
                    }
                } catch { }
            }
        }
    }

    func checkBackgroundColor(type: String) -> Color {
        switch type {
            case "bug",
                 "grass":
                return .green
            case "fire":
                return .red
            case "electric":
                return .yellow
            case "water":
                return .blue
            case "poison":
                return .purple
            case "ground":
                return .brown
            case "flying":
                return .orange
            case "psychic":
                return .pink
            default:
                return .gray
        }
    }
}

#Preview {
    DetailView(
        pokemon: .init(data: .init(name: "Ivysaur"), cover: .init(indexImage: 25))
    )
}
