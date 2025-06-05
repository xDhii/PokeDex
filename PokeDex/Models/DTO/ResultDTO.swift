//
//  ResultDTO.swift
//  PokeDex
//
//  Created by Adriano Valumin on 20/05/25.
//

import Foundation

struct ResultDTO: Decodable {
    let results: [PokemonDTO]
}
