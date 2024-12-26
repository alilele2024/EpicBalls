//
//  ShopView.swift
//  BallGame
//
//  Created by D K on 24.12.2024.
//

import SwiftUI

struct ShopView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var selectedBall = "el6"
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(colors: [.darkPurple, .semiPurple], startPoint: .bottom, endPoint: .top))
                .ignoresSafeArea()
            
            VStack {
                Text("Skins")
                    .foregroundStyle(.white)
                    .font(.system(size: 32, weight: .black))
                Spacer()
            }
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        ZStack {
                            Circle()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.semiPink)
                            
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                        }
                    }
                    
                    Spacer()
                }
                Spacer()
            }
            .padding(.top, 5)
            .padding(.leading, 10)
            
            ScrollView {
                HStack(spacing: 20) {
                    Button {
                        selectedBall = "el6"
                        UserDefaults.standard.setValue("el6", forKey: "ball")
                    } label: {
                        Rectangle()
                            .fill(LinearGradient(colors: [.semiGray1, .semiGray2], startPoint: .top, endPoint: .bottom))
                            .frame(width: 150, height: 150)
                            .cornerRadius(20)
                            .overlay {
                                VStack {
                                    Image("el6")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                    
                                    Rectangle()
                                        .frame(width: 100, height: 30)
                                        .cornerRadius(12)
                                        .foregroundColor(.semiPink)
                                        .overlay {
                                            Text("Set")
                                                .foregroundStyle(.white)
                                        }
                                }
                            }
                    }
                    .overlay {
                        if "el6" == selectedBall {
                            VStack {
                                HStack {
                                    Spacer()
                                    Image(systemName: "checkmark.seal")
                                        .foregroundColor(.semiPink)
                                }
                                Spacer()
                            }
                            .padding(.top, 10)
                            .padding(.trailing, 10)
                        }
                    }
                    
                    
                    Button {
                        selectedBall = "el7"
                        UserDefaults.standard.setValue("el7", forKey: "ball")
                    } label: {
                        Rectangle()
                            .fill(LinearGradient(colors: [.semiGray1, .semiGray2], startPoint: .top, endPoint: .bottom))
                            .frame(width: 150, height: 150)
                            .cornerRadius(20)
                            .overlay {
                                VStack {
                                    Image("el7")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                    
                                    Rectangle()
                                        .frame(width: 100, height: 30)
                                        .cornerRadius(12)
                                        .foregroundColor(.semiPink)
                                        .overlay {
                                            Text("Set")
                                                .foregroundStyle(.white)
                                        }
                                }
                            }
                    }
                    .overlay {
                        if "el7" == selectedBall {
                            VStack {
                                HStack {
                                    Spacer()
                                    Image(systemName: "checkmark.seal")
                                        .foregroundColor(.semiPink)
                                }
                                Spacer()
                            }
                            .padding(.top, 10)
                            .padding(.trailing, 10)
                        }
                    }
                    .opacity(!UserDefaults.standard.bool(forKey: "firstLevelCompleted") ? 0.5 : 1)
                    .overlay {
                        if !UserDefaults.standard.bool(forKey: "firstLevelCompleted") {
                            Image(systemName: "lock")
                                .font(.system(size: 62))
                                .foregroundColor(.white)
                        }
                        
                    }
                    .disabled(!UserDefaults.standard.bool(forKey: "firstLevelCompleted"))
                }
                
                HStack(spacing: 20) {
                    Button {
                        selectedBall = "el8"
                        UserDefaults.standard.setValue("el8", forKey: "ball")
                    } label: {
                        Rectangle()
                            .fill(LinearGradient(colors: [.semiGray1, .semiGray2], startPoint: .top, endPoint: .bottom))
                            .frame(width: 150, height: 150)
                            .cornerRadius(20)
                            .overlay {
                                VStack {
                                    Image("el8")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                    
                                    Rectangle()
                                        .frame(width: 100, height: 30)
                                        .cornerRadius(12)
                                        .foregroundColor(.semiPink)
                                        .overlay {
                                            Text("Set")
                                                .foregroundStyle(.white)
                                        }
                                }
                            }
                    }
                    .overlay {
                        if "el8" == selectedBall {
                            VStack {
                                HStack {
                                    Spacer()
                                    Image(systemName: "checkmark.seal")
                                        .foregroundColor(.semiPink)
                                }
                                Spacer()
                            }
                            .padding(.top, 10)
                            .padding(.trailing, 10)
                        }
                    }
                    .opacity(!UserDefaults.standard.bool(forKey: "secondLevelCompleted") ? 0.5 : 1)
                    .overlay {
                        if !UserDefaults.standard.bool(forKey: "secondLevelCompleted") {
                            Image(systemName: "lock")
                                .font(.system(size: 62))
                                .foregroundColor(.white)
                        }
                        
                    }
                    .disabled(!UserDefaults.standard.bool(forKey: "secondLevelCompleted"))
                    
                    Button {
                        selectedBall = "el4"
                        UserDefaults.standard.setValue("el4", forKey: "ball")
                    } label: {
                        Rectangle()
                            .fill(LinearGradient(colors: [.semiGray1, .semiGray2], startPoint: .top, endPoint: .bottom))
                            .frame(width: 150, height: 150)
                            .cornerRadius(20)
                            .overlay {
                                VStack {
                                    Image("el4")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                    
                                    Rectangle()
                                        .frame(width: 100, height: 30)
                                        .cornerRadius(12)
                                        .foregroundColor(.semiPink)
                                        .overlay {
                                            Text("Set")
                                                .foregroundStyle(.white)
                                        }
                                }
                            }
                    }
                    .overlay {
                        if "el4" == selectedBall {
                            VStack {
                                HStack {
                                    Spacer()
                                    Image(systemName: "checkmark.seal")
                                        .foregroundColor(.semiPink)
                                }
                                Spacer()
                            }
                            .padding(.top, 10)
                            .padding(.trailing, 10)
                        }
                    }
                    .opacity(!UserDefaults.standard.bool(forKey: "thirdLevelCompleted") ? 0.5 : 1)
                    .overlay {
                        if !UserDefaults.standard.bool(forKey: "thirdLevelCompleted") {
                            Image(systemName: "lock")
                                .font(.system(size: 62))
                                .foregroundColor(.white)
                        }
                        
                    }
                    .disabled(!UserDefaults.standard.bool(forKey: "thirdLevelCompleted"))
                }
                .padding(.top, 10)
                
                HStack(spacing: 20) {
                    Button {
                        selectedBall = "el3"
                        UserDefaults.standard.setValue("el3", forKey: "ball")
                    } label: {
                        Rectangle()
                            .fill(LinearGradient(colors: [.semiGray1, .semiGray2], startPoint: .top, endPoint: .bottom))
                            .frame(width: 150, height: 150)
                            .cornerRadius(20)
                            .overlay {
                                VStack {
                                    Image("el3")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                    
                                    Rectangle()
                                        .frame(width: 100, height: 30)
                                        .cornerRadius(12)
                                        .foregroundColor(.semiPink)
                                        .overlay {
                                            Text("Set")
                                                .foregroundStyle(.white)
                                        }
                                }
                            }
                    }
                    .overlay {
                        if "el3" == selectedBall {
                            VStack {
                                HStack {
                                    Spacer()
                                    Image(systemName: "checkmark.seal")
                                        .foregroundColor(.semiPink)
                                }
                                Spacer()
                            }
                            .padding(.top, 10)
                            .padding(.trailing, 10)
                        }
                    }
                    .opacity(!UserDefaults.standard.bool(forKey: "fourthLevelCompleted") ? 0.5 : 1)
                    .overlay {
                        if !UserDefaults.standard.bool(forKey: "fourthLevelCompleted") {
                            Image(systemName: "lock")
                                .font(.system(size: 62))
                                .foregroundColor(.white)
                        }
                        
                    }
                    .disabled(!UserDefaults.standard.bool(forKey: "fourthLevelCompleted"))
                    
                    Button {
                        selectedBall = "el1"
                        UserDefaults.standard.setValue("el1", forKey: "ball")
                    } label: {
                        Rectangle()
                            .fill(LinearGradient(colors: [.semiGray1, .semiGray2], startPoint: .top, endPoint: .bottom))
                            .frame(width: 150, height: 150)
                            .cornerRadius(20)
                            .overlay {
                                VStack {
                                    Image("el1")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                    
                                    Rectangle()
                                        .frame(width: 100, height: 30)
                                        .cornerRadius(12)
                                        .foregroundColor(.semiPink)
                                        .overlay {
                                            Text("Set")
                                                .foregroundStyle(.white)
                                        }
                                }
                            }
                    }
                    .overlay {
                        if "el1" == selectedBall {
                            VStack {
                                HStack {
                                    Spacer()
                                    Image(systemName: "checkmark.seal")
                                        .foregroundColor(.semiPink)
                                }
                                Spacer()
                            }
                            .padding(.top, 10)
                            .padding(.trailing, 10)
                        }
                    }
                    .opacity(!UserDefaults.standard.bool(forKey: "fifthLevelCompleted") ? 0.5 : 1)
                    .overlay {
                        if !UserDefaults.standard.bool(forKey: "fifthLevelCompleted") {
                            Image(systemName: "lock")
                                .font(.system(size: 62))
                                .foregroundColor(.white)
                        }
                        
                    }
                    .disabled(!UserDefaults.standard.bool(forKey: "fifthLevelCompleted"))
                }
                .padding(.top, 10)
                
                HStack(spacing: 20) {
                    Button {
                        selectedBall = "el2"
                        UserDefaults.standard.setValue("el2", forKey: "ball")
                    } label: {
                        Rectangle()
                            .fill(LinearGradient(colors: [.semiGray1, .semiGray2], startPoint: .top, endPoint: .bottom))
                            .frame(width: 150, height: 150)
                            .cornerRadius(20)
                            .overlay {
                                VStack {
                                    Image("el2")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                    
                                    Rectangle()
                                        .frame(width: 100, height: 30)
                                        .cornerRadius(12)
                                        .foregroundColor(.semiPink)
                                        .overlay {
                                            Text("Set")
                                                .foregroundStyle(.white)
                                        }
                                }
                            }
                    }
                    .overlay {
                        if "el2" == selectedBall {
                            VStack {
                                HStack {
                                    Spacer()
                                    Image(systemName: "checkmark.seal")
                                        .foregroundColor(.semiPink)
                                }
                                Spacer()
                            }
                            .padding(.top, 10)
                            .padding(.trailing, 10)
                        }
                    }
                    .opacity(!UserDefaults.standard.bool(forKey: "sixLevelCompleted") ? 0.5 : 1)
                    .overlay {
                        if !UserDefaults.standard.bool(forKey: "sixLevelCompleted") {
                            Image(systemName: "lock")
                                .font(.system(size: 62))
                                .foregroundColor(.white)
                        }
                        
                    }
                    .disabled(!UserDefaults.standard.bool(forKey: "sixLevelCompleted"))
                    
                    Button {
                        selectedBall = "el5"
                        UserDefaults.standard.setValue("el5", forKey: "ball")
                    } label: {
                        Rectangle()
                            .fill(LinearGradient(colors: [.semiGray1, .semiGray2], startPoint: .top, endPoint: .bottom))
                            .frame(width: 150, height: 150)
                            .cornerRadius(20)
                            .overlay {
                                VStack {
                                    Image("el5")
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                    
                                    Rectangle()
                                        .frame(width: 100, height: 30)
                                        .cornerRadius(12)
                                        .foregroundColor(.semiPink)
                                        .overlay {
                                            Text("Set")
                                                .foregroundStyle(.white)
                                        }
                                }
                            }
                    }
                    .overlay {
                        if "el5" == selectedBall {
                            VStack {
                                HStack {
                                    Spacer()
                                    Image(systemName: "checkmark.seal")
                                        .foregroundColor(.semiPink)
                                }
                                Spacer()
                            }
                            .padding(.top, 10)
                            .padding(.trailing, 10)
                        }
                    }
                    .opacity(!UserDefaults.standard.bool(forKey: "sixtLevelCompleted") ? 0.5 : 1)
                    .overlay {
                        if !UserDefaults.standard.bool(forKey: "sixLevelCompleted") {
                            Image(systemName: "lock")
                                .font(.system(size: 62))
                                .foregroundColor(.white)
                        }
                        
                    }
                    .disabled(!UserDefaults.standard.bool(forKey: "sixLevelCompleted"))
                }
                .padding(.top, 10)
            }
            .padding(.top, 70)
            .scrollIndicators(.hidden)
        }
        .onAppear {
            selectedBall = UserDefaults.standard.string(forKey: "ball") ?? "el6"
        }
    }
}

#Preview {
    ShopView()
}
