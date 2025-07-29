//
//  PokemonPhysicalView.swift
//  PokeDex
//
//  Created by Adriano Valumin on 05/06/25.
//

import SwiftUI

struct PokemonPhysicalView: View {
    let height: Int
    let weight: Int
    let identifiers = AccessibilityIdentifier.PokemonDetailView.self

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Physical Characteristics")
                .font(.headline)
                .fontWeight(.semibold)

            HStack(spacing: 24) {
                VStack {
                    Text("Height")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("\(String(format: "%.1f", Double(height) / 10.0)) m")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .accessibilityIdentifier(identifiers.pokemonHeightLabel)
                }

                Divider()
                    .frame(height: 40)

                VStack {
                    Text("Weight")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text("\(String(format: "%.1f", Double(weight) / 10.0)) kg")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .accessibilityIdentifier(identifiers.pokemonWeightLabel)
                }

                Spacer()
            }
        }
        .padding()
        .background(Color(.systemBackground).opacity(0.3))
        .glassEffect(in: .rect)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    PokemonPhysicalView(height: 7, weight: 69)
}
