//
//  ContentView.swift
//  PokeDex
//
//  Created by Adriano Valumin on 29/04/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()

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
                            TextField("Procurar Pokémon...", text: $viewModel.searchText)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)

                        Button(action: {
                            viewModel.showingFavoritesOnly.toggle()
                        }) {
                            HStack {
                                Image(systemName: viewModel.showingFavoritesOnly ? "heart.fill" : "heart")
                                Text(viewModel.showingFavoritesOnly ? "Todos" : "Favoritos")
                                    .font(.caption)
                            }
                            .foregroundColor(viewModel.showingFavoritesOnly ? .red : .blue)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(viewModel.showingFavoritesOnly ? Color.red.opacity(0.1) : Color.blue.opacity(0.1))
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
                        ForEach(viewModel.filteredPokemons) { pokemon in
                            NavigationLink(destination: DetailView(pokemon: pokemon)) {
                                PokemonCard(pokemon: pokemon)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .onAppear {
                                Task {
                                    await viewModel.loadMorePokemonsIfNeeded(for: pokemon)
                                }
                            }
                        }

                            // Loading indicator at the bottom
                        if viewModel.isLoading {
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
                    viewModel.resetPagination()
                    await viewModel.loadPokemons()
                }
            }
            .navigationBarHidden(true)
            .task {
                await viewModel.loadPokemons()
            }
        }
    }
}

#Preview {
    ContentView()
}
