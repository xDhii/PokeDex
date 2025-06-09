//
//  PokemonStatsView.swift
//  PokeDex
//
//  Created by Adriano Valumin on 05/06/25.
//

import SwiftUI

struct PokemonStatsView: View {
    let stats: [PokemonStat]
    let backgroundColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Base Stats")
                .font(.headline)
                .fontWeight(.semibold)

            VStack(spacing: 12) {
                ForEach(stats) { stat in
                    statRow(stat: stat)
                }
            }
        }
        .padding()
        .background(Color(.systemBackground).opacity(0.3))
        .glassEffect(in: .rect)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
    }

    private func statRow(stat: PokemonStat) -> some View {
        VStack(spacing: 4) {
            HStack {
                Text(stat.name.capitalized)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Spacer()
                Text("\(stat.baseStat)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(backgroundColor)
            }

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 6)
                        .clipShape(Capsule())

                    Rectangle()
                        .fill(backgroundColor)
                        .frame(width: min(geometry.size.width * (CGFloat(stat.baseStat) / 255.0), geometry.size.width), height: 6)
                        .clipShape(Capsule())
                        .animation(.easeInOut(duration: 0.5), value: stat.baseStat)
                }
            }
            .frame(height: 6)
        }
    }
}

#Preview {
    PokemonStatsView(
        stats: [
            PokemonStat(name: "hp", baseStat: 35),
            PokemonStat(name: "attack", baseStat: 55),
            PokemonStat(name: "defense", baseStat: 40),
        ],
        backgroundColor: .yellow
    )
}
