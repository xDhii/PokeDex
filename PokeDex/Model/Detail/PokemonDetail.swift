//
//  PokemonDetail.swift
//  PokeDex
//
//  Created by Adriano Valumin on 27/05/25.
//

import Foundation

struct PokemonDetail: Identifiable {
    var id: UUID = UUID()

    let height: Int
    let weight: Int
    let abilities: [String]
    let stats: [PokemonStat]
    let types: [PokemonDetailTypes]

    // Convenience initializer for backward compatibility
    init(types: [PokemonDetailTypes]) {
        self.height = 0
        self.weight = 0
        self.abilities = []
        self.stats = []
        self.types = types
    }

    // Full initializer
    init(height: Int, weight: Int, abilities: [String], stats: [PokemonStat], types: [PokemonDetailTypes]) {
        self.height = height
        self.weight = weight
        self.abilities = abilities
        self.stats = stats
        self.types = types
    }
}

struct PokemonStat: Identifiable {
    let id = UUID()
    let name: String
    let baseStat: Int
}
