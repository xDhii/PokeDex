//
//  File.swift
//  PokeDex
//
//  Created by Adriano Valumin on 22/05/25.
//

import Foundation

struct DetailDTO: Decodable {
    let types: [DetailTypeDTO]
    let height: Int
    let weight: Int
    let abilities: [AbilityDTO]
    let stats: [StatDTO]
    let sprites: SpritesDTO
}

struct AbilityDTO: Decodable {
    let ability: AbilityInfoDTO
}

struct AbilityInfoDTO: Decodable {
    let name: String
}

struct StatDTO: Decodable {
    let baseStat: Int
    let stat: StatInfoDTO
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
}

struct StatInfoDTO: Decodable {
    let name: String
}

struct SpritesDTO: Decodable {
    let frontDefault: String?
    let other: OtherSpritesDTO?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case other
    }
}

struct OtherSpritesDTO: Decodable {
    let officialArtwork: OfficialArtworkDTO?
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtworkDTO: Decodable {
    let frontDefault: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
