import SwiftUI

struct GenerationTabSelector: View {
    @Binding var selectedGeneration: Int
    @Binding var isExpanded: Bool
    let generations = Array(1 ... 9)

    var body: some View {
        GlassEffectContainer {
            ZStack(alignment: .bottomTrailing) {
                // Transparent background to capture user input/touch to cloase the selector
                if isExpanded {
                    Color.black.opacity(0.001)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.spring(duration: 0.3)) {
                                isExpanded = false
                            }
                        }
                }

                // Gen selector (visible only when isExpanded = true)
                if isExpanded {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(generations, id: \.self) { gen in
                                Button(action: {
                                    withAnimation(.spring(duration: 0.3)) {
                                        selectedGeneration = gen
                                        isExpanded = false
                                    }
                                }) {
                                    Text("Gen \(gen)")
                                        .fontWeight(selectedGeneration == gen ? .bold : .regular)
                                        //                                    .foregroundColor(selectedGeneration == gen ? .white : .primary)
                                        .padding(.vertical, 10)
                                        .frame(width: 70)
                                        //                                    .background(
                                        //                                        selectedGeneration == gen
                                        //                                            ? Color.accentColor.opacity(0.7)
                                        //                                            : Color.clear
                                        //                                    )
                                        .clipShape(Capsule())
                                }
                                .glassEffect()
                            }
                        }

                        .padding(.horizontal, 10)
                        .padding(.vertical, 8)
                    }
                    .glassEffect()
                    .frame(width: 320)
                    .clipShape(Capsule())
                    .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
                    .padding(.horizontal, 32)
                    .padding(.bottom, 80) // Space for other buttons
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }

                // Circle button always visible
                Button {
                    withAnimation(.spring(duration: 0.3)) {
                        isExpanded.toggle()
                    }
                } label: {
                    HStack {
                        Spacer()

                        ZStack {
//                            GlassEffectContainer {
                            Circle()
                                .frame(width: 56, height: 56)
                                .shadow(color: .black.opacity(0.1), radius: 10, y: 5)

                            Image(systemName: isExpanded ? "chevron.down" : "line.3.horizontal.decrease")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundStyle(Color.primary)
                                .scaleEffect(isExpanded ? 1.2 : 1.0)
                                .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isExpanded)
//                            }
                        }
//                        .glassEffect()
                    }
                }
            }
        }
    }
}

#Preview {
    ZStack {
        Color.red.opacity(0.2).ignoresSafeArea()
        VStack {
            Spacer()
            GenerationTabSelector(
                selectedGeneration: .constant(2),
                isExpanded: .constant(true)
            )
        }
    }
}
