//
//  MissAlert.swift
//  BallGame
//
//  Created by D K on 23.12.2024.
//

import SwiftUI

struct LabelAlert: View {
    
    @Binding var isAppeared: Bool
    @State private var isShown = true
    var image: String
    
    var body: some View {
        if isAppeared {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .scaleEffect(isShown ? 0.1 : 1)
                .animation(.bouncy, value: isShown)
                .onAppear {
                    withAnimation {
                        isShown.toggle()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation {
                            isAppeared.toggle()
                            isShown.toggle()
                        }
                    }
                }
        }
    
    }
}

#Preview {
    LabelAlert(isAppeared: .constant(true), image: "missLabel")
}
