//
//  BackgroundView.swift
//  PokeDex
//
//  Created by Adriano Valumin on 08/06/25.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack {
            Color.red
                .ignoresSafeArea()

            RoundedRectangle(cornerRadius: 13)
                .padding()
                .foregroundStyle(.white)
                .background(.red)
        }
    }
}

#Preview {
    BackgroundView()
}
