//
//  Network.swift
//  PokeDex
//
//  Created by Adriano Valumin on 20/05/25.
//

import Foundation

enum NetworkErrors: Error {
    case url
    case request
}

class Network {
    static let shared: Network = Network()
    private init() {}

    func fetch(url: URL?) async throws -> Data {
        guard let url else { throw NetworkErrors.url }
        do {
            let (data, _) = try await URLSession.shared.data(for: .init(url: url))
            return data
        } catch {
            throw NetworkErrors.request
        }
    }

    func fetchList(offset: Int = 0, limit: Int = 20) async throws -> [PokemonDTO] {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?offset=\(offset)&limit=\(limit)") else {
            throw NetworkErrors.url
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let result = try JSONDecoder().decode(ResultDTO.self, from: data)
            return result.results
        } catch {
            throw NetworkErrors.request
        }
    }

    func fetchDetail(name: String) async throws -> DetailDTO {
        do {
            let data = try await fetch(url: URL(string: "https://pokeapi.co/api/v2/pokemon/\(name)"))
            let result = try JSONDecoder().decode(DetailDTO.self, from: data)
            return result
        } catch {
            throw NetworkErrors.request
        }
    }
}
