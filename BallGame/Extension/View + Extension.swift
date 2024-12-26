//
//  View + Extension.swift
//  BallGame
//
//  Created by D K on 24.12.2024.
//

import SwiftUI

extension Color {
    static let darkPurple = Color(#colorLiteral(red: 0, green: 0, blue: 0.1215686275, alpha: 1))
    static let semiPurple = Color(#colorLiteral(red: 0.02352941176, green: 0, blue: 0.09019607843, alpha: 1))
    static let semiPink = Color(#colorLiteral(red: 0.737254902, green: 0.1529411765, blue: 0.4784313725, alpha: 1))
    static let semiTeal = Color(#colorLiteral(red: 0.5450980392, green: 0.8823529412, blue: 0.8705882353, alpha: 1))
    
    static let semiGray1 = Color(#colorLiteral(red: 0.6470588235, green: 0.6274509804, blue: 0.7725490196, alpha: 1))
    static let semiGray2 = Color(#colorLiteral(red: 0.2784313725, green: 0.2705882353, blue: 0.337254902, alpha: 1))
}

extension View {
    func size() -> CGSize {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        return window.screen.bounds.size
    }
}
