import SwiftUI

struct FavoriteFloatingButton: View {
    @Binding var showingFavoritesOnly: Bool

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                        showingFavoritesOnly.toggle()
                    }
                }) {
                    Image(systemName: showingFavoritesOnly ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                        .frame(width: 56, height: 56)
                }
                .scaleEffect(showingFavoritesOnly ? 1.1 : 1.0)
                .glassEffect(.clear , in: .circle)
                .animation(.spring(response: 0.4, dampingFraction: 0.6), value: showingFavoritesOnly)
                .accessibilityIdentifier("favoritesFilterButton")
            }
        }
    }
}

#Preview {
    FavoriteFloatingButton(showingFavoritesOnly: .constant(false))
}
