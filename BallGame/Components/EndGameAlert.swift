//
//  EndGameAlert.swift
//  BallGame
//
//  Created by D K on 23.12.2024.
//

import SwiftUI

struct EndGameAlert: View {
    
    var score: String
    var isCompleted: Bool
    var again: () -> ()
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
                        
                        Text("Score: \(score)")
                            .foregroundStyle(.white)
                            .font(.system(size: 24, weight: .black))
                        
                        Button {
                            again()
                        } label: {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.semiTeal)
                                    .frame(width: 150, height: 40)
                                    .cornerRadius(12)
                                
                                Text("Try again")
                                    .foregroundStyle(.white)
                                    .font(.system(size: 20, weight: .black))
                            }
                           
                        }
                        
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
                        .padding(.bottom, 30)
                    }
                }
            
            if !isCompleted {
                Image("endGame")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .offset(y: -120)
            } else {
                Image("completedLabel")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200)
                    .offset(y: -120)
            }
            
            
        }
    }
}

#Preview {
    EndGameAlert(score: "100", isCompleted: true) {
        
    } close: {
        
    }
}
