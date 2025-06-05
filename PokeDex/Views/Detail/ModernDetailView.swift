//
//  ModernDetailView.swift
//  PokeDex
//
//  Created by Adriano Valumin on 20/05/25.
//

import SwiftUI

struct ModernDetailView: View {
    var pokemon: Pokemon
    @State var detail: PokemonDetail?
    @State var backgroundColorPokemonType: Color = .gray
    @ObservedObject private var pokemonManager = PokemonManager.shared
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [backgroundColorPokemonType.opacity(0.3), backgroundColorPokemonType.opacity(0.1)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    // Header Section
                    headerSection

                    // Types Section
                    if let detail {
                        typesSection(types: detail.types)
                    }

                    // Physical Characteristics
                    if let detail {
                        physicalCharacteristicsSection(detail: detail)
                    }

                    // Abilities Section
                    if let detail {
                        abilitiesSection(abilities: detail.abilities)
                    }

                    // Stats Section
                    if let detail {
                        statsSection(stats: detail.stats)
                    }
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    Button(action: toggleFavorite) {
                        Image(systemName: pokemon.isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(pokemon.isFavorite ? .red : .gray)
                            .font(.title2)
                    }

                    Button(action: deletePokemon) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                            .font(.title2)
                    }
                }
            }
        }
        .onAppear {
            Task {
                await fetchPokemonDetail()
            }
        }
    }

    // MARK: - Header Section
    private var headerSection: some View {
        VStack(spacing: 16) {
            AsyncImage(url: pokemon.cover.image) { image in
                image.image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .frame(width: 200, height: 200)
            .background(
                Circle()
                    .fill(backgroundColorPokemonType.opacity(0.2))
                    .shadow(color: backgroundColorPokemonType.opacity(0.3), radius: 10, x: 0, y: 5)
            )

            Text(pokemon.data.name.capitalized)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
        }
        .padding(.top)
    }

    // MARK: - Types Section
    private func typesSection(types: [PokemonDetailTypes]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Types")
                .font(.headline)
                .fontWeight(.semibold)

            HStack {
                ForEach(types) { type in
                    Text(type.name.capitalized)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(checkBackgroundColor(type: type.name))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                Spacer()
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }

    // MARK: - Physical Characteristics Section
    private func physicalCharacteristicsSection(detail: PokemonDetail) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Physical Characteristics")
                .font(.headline)
                .fontWeight(.semibold)

            HStack(spacing: 24) {
                VStack {
                    Text("Height")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("\(String(format: "%.1f", Double(detail.height) / 10.0)) m")
                        .font(.title3)
                        .fontWeight(.semibold)
                }

                Divider()
                    .frame(height: 40)

                VStack {
                    Text("Weight")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("\(String(format: "%.1f", Double(detail.weight) / 10.0)) kg")
                        .font(.title3)
                        .fontWeight(.semibold)
                }

                Spacer()
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }

    // MARK: - Abilities Section
    private func abilitiesSection(abilities: [String]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Abilities")
                .font(.headline)
                .fontWeight(.semibold)

            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 8) {
                ForEach(abilities, id: \.self) { ability in
                    Text(ability.capitalized)
                        .font(.subheadline)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(backgroundColorPokemonType.opacity(0.2))
                        .clipShape(Capsule())
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }

    // MARK: - Stats Section
    private func statsSection(stats: [PokemonStat]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Base Stats")
                .font(.headline)
                .fontWeight(.semibold)

            VStack(spacing: 12) {
                ForEach(stats) { stat in
                    statRow(stat: stat)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }

    private func statRow(stat: PokemonStat) -> some View {
        VStack(spacing: 4) {
            HStack {
                Text(stat.name.capitalized)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Spacer()
                Text("\(stat.baseStat)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(backgroundColorPokemonType)
            }

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 6)
                        .clipShape(Capsule())

                    Rectangle()
                        .fill(backgroundColorPokemonType)
                        .frame(width: min(geometry.size.width * (CGFloat(stat.baseStat) / 255.0), geometry.size.width), height: 6)
                        .clipShape(Capsule())
                        .animation(.easeInOut(duration: 0.5), value: stat.baseStat)
                }
            }
            .frame(height: 6)
        }
    }

    // MARK: - Actions
    private func toggleFavorite() {
        pokemonManager.toggleFavorite(pokemon: pokemon)
    }

    private func deletePokemon() {
        pokemonManager.deletePokemon(pokemon: pokemon)
        dismiss()
    }

    // MARK: - Data Fetching
    private func fetchPokemonDetail() async {
        do {
            let pokemonDetail = try await Network.shared.fetchDetail(name: pokemon.data.name)

            let types = pokemonDetail.types.map { detail in
                PokemonDetailTypes(name: detail.type.name)
            }

            let abilities = pokemonDetail.abilities.map { $0.ability.name }

            let stats = pokemonDetail.stats.map { stat in
                PokemonStat(name: stat.stat.name, baseStat: stat.baseStat)
            }

            detail = PokemonDetail(
                height: pokemonDetail.height,
                weight: pokemonDetail.weight,
                abilities: abilities,
                stats: stats,
                types: types
            )

            if let firstType = types.first {
                backgroundColorPokemonType = checkBackgroundColor(type: firstType.name)
            }
        } catch {
            print("Error fetching Pokémon detail: \(error)")
        }
    }

    func checkBackgroundColor(type: String) -> Color {
        switch type {
            case "bug", "grass":
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
            case "fairy":
                return .pink
            case "fighting":
                return .red
            case "normal":
                return .gray
            case "rock":
                return .brown
            case "steel":
                return .gray
            case "ice":
                return .cyan
            case "ghost":
                return .purple
            case "dragon":
                return .blue
            case "dark":
                return .black
            default:
                return .gray
        }
    }
}

#Preview {
    NavigationView {
        ModernDetailView(
            pokemon: .init(data: .init(name: "Ivysaur"), cover: .init(indexImage: 25))
        )
    }
}
