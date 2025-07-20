//
//  BackgroundView.swift
//  PokeDex
//
//  Created by Adriano Valumin on 08/06/25.
//

import SwiftUI

struct BackgroundView<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack {
            Color.red
                .ignoresSafeArea()

            RoundedRectangle(cornerRadius: 13)
                .padding(.horizontal, 6)
                .padding(.bottom, -50)
                .foregroundStyle(.white)
                .background(.red)
                .overlay {
                    content
                }
        }
    }
}

#Preview {
    BackgroundView {
        Text("Example content")
    }
}
