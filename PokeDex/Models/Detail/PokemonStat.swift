//
//  PokemonStat.swift
//  PokeDex
//
//  Created by Adriano Valumin on 05/06/25.
//

import Foundation

struct PokemonStat: Identifiable {
    let id = UUID()
    let name: String
    let baseStat: Int
}
