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

    private var numberOfColumns: Int {
        return sizeClass == .compact ? 2 : 3
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // MARK: - Header with logo and filters

                VStack {
                    Image("pokemonLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 60)
                        .shadow(color: .yellow.opacity(0.7), radius: 13, x: 0, y: 0)

                    // MARK: - Search and filter controls

                    HStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)

                            TextField("Search Pokémon...", text: $viewModel.searchText)

                            if !viewModel.searchText.isEmpty {
                                Button {
                                    withAnimation {
                                        viewModel.searchText = ""
                                    }
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)

                        Button(action: {
                            withAnimation {
                                viewModel.showingFavoritesOnly.toggle()
                            }
                        }) {
                            HStack {
                                Image(systemName: viewModel.showingFavoritesOnly ? "heart.fill" : "heart")
                                Text(viewModel.showingFavoritesOnly ? "All" : "Favorites")
                                    .font(.caption)
                            }
                            .foregroundColor(viewModel.showingFavoritesOnly ? .red : .blue)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(viewModel.showingFavoritesOnly ? Color.red.opacity(0.1) : Color.blue.opacity(0.1))
                            .cornerRadius(10)
                        }
                        .padding(.trailing, 2)
                    }
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.horizontal, 8)
                .padding(.bottom, 10)
                .background(Color(.red))

                // MARK: - Pokemon grid with infinite scrolling

                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .padding(.horizontal, 6)
                        .background(.red)
                        .foregroundStyle(Color(.systemBackground))
                        .ignoresSafeArea()
                        .overlay {
                            ScrollView {
                                LazyVGrid(
                                    columns: Array(
                                        repeating: GridItem(.flexible(), spacing: 8),
                                        count: numberOfColumns
                                    ),
                                    spacing: 12
                                ) {
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

                                    // MARK: - Loading indicator at the bottom

                                    if viewModel.isLoading {
                                        HStack {
                                            Spacer()
                                            ProgressView("Loading more Pokémons...")
                                                .foregroundColor(.secondary)
                                                .font(.caption)
                                            Spacer()
                                        }
                                        .padding()
                                        .gridCellColumns(
                                            numberOfColumns
                                        )
                                    }
                                }
                                .padding(.top, 2)
                                .padding(.horizontal, 16)
                            }
                            .scrollIndicators(.hidden)
                            .refreshable {
                                viewModel.resetPagination()
                                await viewModel.loadPokemons()
                            }
                        }
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
