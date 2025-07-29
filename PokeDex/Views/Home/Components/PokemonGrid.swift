import SwiftUI

struct PokemonGrid: View {
    @ObservedObject var viewModel: ContentViewModel
    let numberOfColumns: Int

    var body: some View {
        LazyVGrid(
            columns: Array(
                repeating: GridItem(.flexible(), spacing: 8),
                count: numberOfColumns
            ),
            spacing: 12
        ) {
            ForEach(viewModel.filteredPokemons) { pokemon in
                NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
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
                    ProgressView("Loading more Pokémons...")
                        .foregroundColor(.secondary)
                        .font(.caption)
                    Spacer()
                }
                .padding()
                .gridCellColumns(numberOfColumns)
            }
        }
        .padding(.top, 10)
        .padding(.horizontal, 16)
    }
}

#Preview {
    PokemonGrid(
        viewModel: ContentViewModel(),
        numberOfColumns: 2
    )
}
