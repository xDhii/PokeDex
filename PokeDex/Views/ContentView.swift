//
//  ContentView.swift
//  PokeDex
//
//  Created by Adriano Valumin on 29/04/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @Environment(\.horizontalSizeClass) private var sizeClass
    @State private var isGenerationSelectorExpanded = false

    private var numberOfColumns: Int {
        return sizeClass == .compact ? 2 : 3
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    // MARK: - Header with logo and searchbar

                    VStack {
                        PokemonHeader()

                        // Search Bar
                        SearchBar(searchText: $viewModel.searchText)
                            .background(Color(.systemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding(.horizontal, 8)
                    .padding(.bottom, 10)
                    .background(Color(.red))

                    // MARK: - Pokémons Grid

                    BackgroundView {
                        ScrollView {
                            PokemonGrid(
                                viewModel: viewModel,
                                numberOfColumns: numberOfColumns
                            )
                        }
                        .scrollIndicators(.hidden)
                        .refreshable {
                            viewModel.resetPagination()
                            await viewModel.loadPokemons()
                        }
                    }
                }

                // MARK: - Floating Elements

                ZStack {
                    VStack {
                        // Floating favorites button
                        if !isGenerationSelectorExpanded {
                            FavoriteFloatingButton(showingFavoritesOnly: $viewModel.showingFavoritesOnly)
                        }
                        // Pokemon Gen floating selector
                        GenerationTabSelector(
                            selectedGeneration: $viewModel.selectedGeneration,
                            isExpanded: $isGenerationSelectorExpanded
                        )
                    }
                    .padding(.trailing, 16)
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
