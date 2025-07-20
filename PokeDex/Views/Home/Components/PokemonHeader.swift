import SwiftUI

struct PokemonHeader: View {
    var body: some View {
        Image("pokemonLogo")
            .resizable()
            .scaledToFit()
            .frame(height: 60)
            .shadow(color: .yellow.opacity(0.7), radius: 13, x: 0, y: 0)
    }
}

#Preview {
    PokemonHeader()
        .padding()
        .background(Color(.red))
}