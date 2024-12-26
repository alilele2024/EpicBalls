//
//  ErrorAlertView.swift
//  BallGame
//
//  Created by D K on 24.12.2024.
//

import SwiftUI

struct ErrorAlertView: View {
    
    var close: () -> ()
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(colors: [.semiGray1, .semiGray2], startPoint: .top, endPoint: .bottom))
                .frame(width: size().width - 90, height: 250)
                .cornerRadius(20)
                .overlay {
                    VStack {
                        Spacer()
                        
                        Text("To open this level, complete the previous one.")
                            .foregroundStyle(.white)
                            .font(.system(size: 24, weight: .black))
                            .padding(.horizontal)
                            .multilineTextAlignment(.center)
                        
                        Button {
                            close()
                        } label: {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.semiPink)
                                    .frame(width: 150, height: 40)
                                    .cornerRadius(12)
                                
                                Text("Exit")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 20, weight: .black))
                            }
                        }
                        Spacer()
                    }
                }
        }
    }
}

#Preview {
    ErrorAlertView() {}
}
