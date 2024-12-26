//
//  LevelsView.swift
//  BallGame
//
//  Created by D K on 24.12.2024.
//

import SwiftUI

struct LevelsView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var isFirstShown = false
    @State private var isSecondShown = false
    @State private var isThirdShown = false
    @State private var isFourthShown = false
    @State private var isFifthShown = false
    @State private var isSixShown = false
    
    @State private var isAlertShown = false
    
    @State private var first = false
    @State private var second = false
    @State private var third = false
    @State private var fourth = false
    @State private var fifth = false
    @State private var sixth = false
    
    @State private var counter = 0
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(colors: [.darkPurple, .semiPurple], startPoint: .bottom, endPoint: .top))
                .ignoresSafeArea()
            
            VStack {
                Text("Levels")
                    .foregroundStyle(.white)
                    .font(.system(size: 32, weight: .black))
                Spacer()
                Text("\(counter)")
                    .foregroundColor(.darkPurple)
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
            
            //LEVELS
            ScrollView {
                VStack {
                    HStack(spacing: 20) {
                        Button {
                            isFirstShown.toggle()
                        } label: {
                            Image("l3")
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                        
                        Button {
                            if second {
                                isSecondShown.toggle()
                            } else {
                                withAnimation(.bouncy) {
                                    isAlertShown.toggle()
                                }
                            }
                            
                        } label: {
                            Image(UserDefaults.standard.bool(forKey: "firstLevelCompleted") ? "l7" : "lock")
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                        
                        Button {
                            if third {
                                isThirdShown.toggle()
                            } else {
                                withAnimation(.bouncy) {
                                    isAlertShown.toggle()
                                }
                            }
                            
                        } label: {
                            Image(UserDefaults.standard.bool(forKey: "secondLevelCompleted") ? "l2" : "lock")
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                    }
                    
                    HStack(spacing: 20) {
                        Button {
                            if fourth {
                                isFourthShown.toggle()
                            } else {
                                withAnimation(.bouncy) {
                                    isAlertShown.toggle()
                                }
                            }
                            
                        } label: {
                            Image(UserDefaults.standard.bool(forKey: "thirdLevelCompleted") ? "l6" : "lock")
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                        
                        Button {
                            if fifth {
                                isFifthShown.toggle()
                            } else {
                                withAnimation(.bouncy) {
                                    isAlertShown.toggle()
                                }
                            }
                            
                        } label: {
                            Image(UserDefaults.standard.bool(forKey: "fourthLevelCompleted") ? "l4" : "lock")
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                        
                        Button {
                            if sixth {
                                isSixShown.toggle()
                            } else {
                                withAnimation(.bouncy) {
                                    isAlertShown.toggle()
                                }
                            }
                            
                        } label: {
                            Image(UserDefaults.standard.bool(forKey: "fifthLevelCompleted") ? "l1" : "lock")
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                    }
                    .padding(.top, 5)
                    
                    HStack(spacing: 20) {
                        Button {
                            withAnimation(.bouncy) {
                                isAlertShown.toggle()
                            }
                        } label: {
                            Image("lock")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                        }
                        
                        Button {
                            withAnimation(.bouncy) {
                                isAlertShown.toggle()
                            }
                        } label: {
                            Image("lock")
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                        
                        Button {
                            withAnimation(.bouncy) {
                                isAlertShown.toggle()
                            }
                        } label: {
                            Image("lock")
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                    }
                    
                    HStack(spacing: 20) {
                        Button {
                            withAnimation(.bouncy) {
                                isAlertShown.toggle()
                            }
                        } label: {
                            Image("lock")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                        }
                        
                        Button {
                            withAnimation(.bouncy) {
                                isAlertShown.toggle()
                            }
                        } label: {
                            Image("lock")
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                        
                        Button {
                            withAnimation(.bouncy) {
                                isAlertShown.toggle()
                            }
                        } label: {
                            Image("lock")
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                    }
                    
                    HStack(spacing: 20) {
                        Button {
                            withAnimation(.bouncy) {
                                isAlertShown.toggle()
                            }
                        } label: {
                            Image("lock")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                        }
                        
                        Button {
                            withAnimation(.bouncy) {
                                isAlertShown.toggle()
                            }
                        } label: {
                            Image("lock")
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                        
                        Button {
                            withAnimation(.bouncy) {
                                isAlertShown.toggle()
                            }
                        } label: {
                            Image("lock")
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                    }
                    
                    HStack(spacing: 20) {
                        Button {
                            withAnimation(.bouncy) {
                                isAlertShown.toggle()
                            }
                        } label: {
                            Image("lock")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                        }
                        
                        Button {
                            withAnimation(.bouncy) {
                                isAlertShown.toggle()
                            }
                        } label: {
                            Image("lock")
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                        
                        Button {
                            withAnimation(.bouncy) {
                                isAlertShown.toggle()
                            }
                        } label: {
                            Image("lock")
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                    }
                    .padding(.bottom, 150)
                }
            }
            .scrollIndicators(.hidden)
            .padding(.top, 60)
        }
        .overlay {
            if isAlertShown {
                ZStack {
                    Rectangle()
                        .background(.thinMaterial)
                        .ignoresSafeArea()
                    
                    ErrorAlertView {
                        withAnimation(.bouncy) {
                            isAlertShown.toggle()
                        }
                    }
                }
            }
        }
        .onAppear {
            checkAccess()
        }
        .fullScreenCover(isPresented: $isFirstShown) {
            FirstLevelView()
                .onDisappear {
                    checkAccess()
                }
        }
        .fullScreenCover(isPresented: $isSecondShown) {
            SecondLevelView()
                .onDisappear {
                    checkAccess()
                }
        }
        .fullScreenCover(isPresented: $isThirdShown) {
            ThirdLevelView()
                .onDisappear {
                    checkAccess()
                }
        }
        .fullScreenCover(isPresented: $isFourthShown) {
            FourthLevelView()
                .onDisappear {
                    checkAccess()
                }
        }
        .fullScreenCover(isPresented: $isFifthShown) {
            FifthLevelView()
                .onDisappear {
                    checkAccess()
                }
        }
        .fullScreenCover(isPresented: $isSixShown) {
            SixLevelView()
        }
       
    }
    
    func checkAccess() {
        second = UserDefaults.standard.bool(forKey: "firstLevelCompleted")
        third = UserDefaults.standard.bool(forKey: "secondLevelCompleted")
        fourth = UserDefaults.standard.bool(forKey: "thirdLevelCompleted")
        fifth = UserDefaults.standard.bool(forKey: "fourthLevelCompleted")
        sixth = UserDefaults.standard.bool(forKey: "fifthLevelCompleted")
        counter += 1
    }
}

#Preview {
    LevelsView()
}
