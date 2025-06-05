//
//  PokemonCover.swift
//  PokeDex
//
//  Created by Adriano Valumin on 29/04/25.
//

import Foundation

struct PokemonCover {
    private let baseImage: String = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/"
    private let extensionImage = ".png"
    let indexImage: Int
    var image: URL? {
        URL(string: String(baseImage + String(indexImage) + extensionImage))
    }

    init(indexImage: Int) {
        self.indexImage = indexImage
    }
}
