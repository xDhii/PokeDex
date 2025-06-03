//
//  Pokemon.swift
//  PokeDex
//
//  Created by Adriano Valumin on 29/04/25.
//

import Foundation

struct Pokemon: Identifiable {
    var id: UUID = UUID()

    var data: PokemonDTO
    var cover: PokemonCover
    var isFavorite: Bool = false
}
