//
//  ContentView.swift
//  PokeDex
//
//  Created by Adriano Valumin on 29/04/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var pokemonManager = PokemonManager.shared
    @State private var showingFavoritesOnly = false
    @State private var searchText = ""

    var filteredPokemons: [Pokemon] {
        let pokemons = showingFavoritesOnly ? pokemonManager.favoritePokemons : pokemonManager.pokemonList

        if searchText.isEmpty {
            return pokemons
        } else {
            return pokemons.filter { $0.data.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Header with logo and filters
                VStack(spacing: 16) {
                    Image("pokemonLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 60)

                    // Search and filter controls
                    HStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            TextField("Procurar Pokémon...", text: $searchText)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)

                        Button(action: {
                            showingFavoritesOnly.toggle()
                        }) {
                            HStack {
                                Image(systemName: showingFavoritesOnly ? "heart.fill" : "heart")
                                Text(showingFavoritesOnly ? "Todos" : "Favoritos")
                                    .font(.caption)
                            }
                            .foregroundColor(showingFavoritesOnly ? .red : .blue)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(showingFavoritesOnly ? Color.red.opacity(0.1) : Color.blue.opacity(0.1))
                            .cornerRadius(10)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
                .background(Color(.systemBackground))

                // Pokemon grid with infinite scrolling
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: 8),
                        GridItem(.flexible(), spacing: 8)
                    ], spacing: 12) {
                        ForEach(filteredPokemons) { pokemon in
                            NavigationLink(destination: ModernDetailView(pokemon: pokemon)) {
                                ModernPokemonCard(pokemon: pokemon)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .onAppear {
                                Task {
                                    await pokemonManager.loadMorePokemonsIfNeeded(for: pokemon)
                                }
                            }
                        }

                        // Loading indicator at the bottom
                        if pokemonManager.isLoading {
                            HStack {
                                Spacer()
                                ProgressView("Carregando mais Pokémons...")
                                    .foregroundColor(.secondary)
                                    .font(.caption)
                                Spacer()
                            }
                            .padding()
                            .gridCellColumns(2) // Spans both columns
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .refreshable {
                    pokemonManager.resetPagination()
                    await pokemonManager.loadPokemons()
                }
            }
            .navigationBarHidden(true)
            .task {
                await pokemonManager.loadPokemons()
            }
        }
    }
}

#Preview {
    ContentView()
}
