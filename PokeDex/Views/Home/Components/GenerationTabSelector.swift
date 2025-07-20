import SwiftUI

struct GenerationTabSelector: View {
    @Binding var selectedGeneration: Int
    @Binding var isExpanded: Bool
    let generations = Array(1 ... 9)

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // Generation selector popup
            if isExpanded {
                VStack(spacing: 0) {
                    ForEach(generations, id: \.self) { gen in
                        Button(action: {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                                selectedGeneration = gen
                            }
                        }) {
                            HStack {
                                Text("Gen \(gen)")
                                    .font(.system(size: 17, weight: selectedGeneration == gen ? .semibold : .regular))
                                    .foregroundStyle(selectedGeneration == gen ? Color.accentColor : Color.primary)

                                Spacer()

                                if selectedGeneration == gen {
                                    Image(systemName: "checkmark")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundStyle(Color.accentColor)
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 12)
                        }

                        if gen < generations.last! {
                            Divider()
                                .background(Color.primary.opacity(0.1))
                        }
                    }
                }
                .glassEffect(in: .rect)
                .frame(width: 280)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .padding(.bottom, 70)
                .padding(.horizontal, 20)
                .transition(
                    .asymmetric(
                        insertion: .scale(scale: 0.8, anchor: .bottomTrailing)
                            .combined(with: .opacity),
                        removal: .scale(scale: 0.95, anchor: .bottomTrailing)
                            .combined(with: .opacity)
                    )
                )
            }

            // Floating action button
            VStack {
                HStack {
                    Spacer()

                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            isExpanded.toggle()
                        }
                    } label: {
                        ZStack {
                            Image(systemName: isExpanded ? "xmark" : "line.3.horizontal.decrease")
                                .frame(width: 56, height: 56)
                                .font(.system(size: 20, weight: .medium))
                                .foregroundStyle(Color.primary)
                                .rotationEffect(.degrees(isExpanded ? 90 : 0))
                                .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isExpanded)
                        }
                    }
                    .glassEffect()
                }
            }
        }
    }
}

#Preview {
    ZStack {
        LinearGradient(
            colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.8)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()

        GenerationTabSelector(
            selectedGeneration: .constant(2),
            isExpanded: .constant(true)
        )
    }
}
