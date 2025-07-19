import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String

    var clearSearchFieldButton: some View {
        Button {
            withAnimation {
                searchText = ""
            }
        } label: {
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(.gray)
        }
        .accessibilityIdentifier("clearSearchFieldButton")
    }
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            TextField("Search Pokémon...", text: $searchText)
                .accessibilityIdentifier("searchTextField")

            if !searchText.isEmpty {
                clearSearchFieldButton
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color(.systemBackground))
        .cornerRadius(10)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    SearchBar(searchText: .constant("Pikachu"))
        .padding()
        .background(Color.gray.opacity(0.2))
}
