//
//  MainView.swift
//  BallGame
//
//  Created by D K on 24.12.2024.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var musicPlayer = MusicPlayer.shared
    @StateObject private var soundPlayer = SoundPlayer.shared
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .fill(LinearGradient(colors: [.darkPurple, .semiPurple], startPoint: .bottom, endPoint: .top))
                    .ignoresSafeArea()
                
                VStack {
                    
                    Image("logoLabel")
                        .resizable()
                        .scaledToFill()
                        .frame(width: size().width - 70, height: 250)
                    
                    Spacer()
                    
                    NavigationLink {
                        LevelsView().navigationBarBackButtonHidden()
                    } label: {
                        Rectangle()
                            .frame(width: size().width - 80, height: 70)
                            .cornerRadius(20)
                            .foregroundColor(.semiPink)
                            .overlay {
                                Text("start playing".uppercased())
                                    .foregroundStyle(.white)
                                    .font(.system(size: 26, weight: .black))
                            }
                    }
                    
                    NavigationLink {
                        ShopView().navigationBarBackButtonHidden()
                    } label: {
                        Rectangle()
                            .frame(width: size().width - 80, height: 70)
                            .cornerRadius(20)
                            .foregroundColor(.semiPink)
                            .overlay {
                                Text("shop".uppercased())
                                    .foregroundStyle(.white)
                                    .font(.system(size: 26, weight: .black))
                            }
                    }
                    
                    NavigationLink {
                        SettingsView().navigationBarBackButtonHidden()
                    } label: {
                        Rectangle()
                            .frame(width: size().width - 80, height: 70)
                            .cornerRadius(20)
                            .foregroundColor(.semiPink)
                            .overlay {
                                Text("settings".uppercased())
                                    .foregroundStyle(.white)
                                    .font(.system(size: 26, weight: .black))
                            }
                    }
                    Spacer()
                }
            }
        }
        .onAppear {
            if musicPlayer.isMusicOn {
                musicPlayer.playMusic()
            }
            soundPlayer.isSoundOn = true
        }
    }
}

#Preview {
    MainView()
}
