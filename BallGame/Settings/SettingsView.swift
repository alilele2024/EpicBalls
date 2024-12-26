//
//  SettingsView.swift
//  BallGame
//
//  Created by D K on 24.12.2024.
//

import SwiftUI
import MessageUI
import StoreKit
import AVFoundation


struct SettingsView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var musicPlayer = MusicPlayer.shared
    @StateObject private var soundPlayer = SoundPlayer.shared
    
    @State private var showMail = false
    @State private var isAlertShown = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(colors: [.darkPurple, .semiPurple], startPoint: .bottom, endPoint: .top))
                .ignoresSafeArea()
            
            VStack {
                Text("Settings")
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
                HStack {
                    Text("USAGE")
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
                .padding(.leading)
                
                Rectangle()
                    .frame(width: size().width - 40, height: 60)
                    .foregroundColor(.purple.opacity(0.5))
                    .cornerRadius(18)
                    .overlay {
                        HStack {
                            Text("Sounds")
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            Toggle("", isOn: $soundPlayer.isSoundOn)
                        }
                        .padding(.horizontal)
                    }
                
                Rectangle()
                    .frame(width: size().width - 40, height: 60)
                    .foregroundColor(.purple.opacity(0.5))
                    .cornerRadius(18)
                    .overlay {
                        HStack {
                            Text("Music")
                                .foregroundStyle(.white)
                            
                            Spacer()
                            
                            Toggle("", isOn: $musicPlayer.isMusicOn)
                        }
                        .padding(.horizontal)
                    }                
                
                HStack {
                    Text("SUPPORT")
                        .foregroundColor(.gray)
                    
                    Spacer()
                }
                .padding(.leading)
                .padding(.top)
                
                Button {
                    if MFMailComposeViewController.canSendMail() {
                        showMail.toggle()
                    } else {
                        isAlertShown.toggle()
                    }
                } label: {
                    Rectangle()
                        .frame(width: size().width - 40, height: 60)
                        .foregroundColor(.purple.opacity(0.5))
                        .cornerRadius(18)
                        .overlay {
                            HStack {
                                Text("Feedback")
                                    .foregroundStyle(.white)
                                
                                
                            }
                            .padding(.horizontal)
                        }
                }
                .sheet(isPresented: $showMail) {
                    MailComposeView(isShowing: $showMail, subject: "Feedback", recipientEmail: "besterGamerBaller@gmail.com", textBody: "")
                }
                .alert("Unable to send email", isPresented: $isAlertShown) {
                    Button {
                        isAlertShown.toggle()
                    } label: {
                        Text("Ok")
                    }
                } message: {
                    Text("Your device does not have a mail client configured. Please configure your mail or contact support on our website.")
                }
                
                Button {
                    requestAppReview()
                } label: {
                    Rectangle()
                        .frame(width: size().width - 40, height: 60)
                        .foregroundColor(.purple.opacity(0.5))
                        .cornerRadius(18)
                        .overlay {
                            HStack {
                                Text("Rate the App 💜")
                                    .foregroundStyle(.white)
                                
                                
                            }
                            .padding(.horizontal)
                        }
                }
                
                
                Button {
                    openPrivacyPolicy()
                } label: {
                    Rectangle()
                        .frame(width: size().width - 40, height: 60)
                        .foregroundColor(.purple.opacity(0.5))
                        .cornerRadius(18)
                        .overlay {
                            HStack {
                                Text("Privacy Policy")
                                    .foregroundStyle(.white)
                                
                                
                            }
                            .padding(.horizontal)
                        }
                }
            }
            .scrollIndicators(.hidden)
            .padding(.top, 50)
        }
    }
    
    func openPrivacyPolicy() {
        if let url = URL(string: "https://sites.google.com/view/epic-balls/privacy-policy") {
            UIApplication.shared.open(url)
        }
    }
    
    func requestAppReview() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}

#Preview {
    SettingsView()
}

class MusicPlayer: ObservableObject {
    static let shared = MusicPlayer()
    private var audioPlayer: AVAudioPlayer?

    @Published var isMusicOn: Bool {
        didSet {
            UserDefaults.standard.set(isMusicOn, forKey: "isMusicOn")
            if isMusicOn {
                playMusic()
            } else {
                stopMusic()
            }
        }
    }

    private init() {
        // Проверка, был ли это первый запуск
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
        if isFirstLaunch {
            UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
            UserDefaults.standard.set(true, forKey: "isMusicOn") // Музыка включена по умолчанию
        }

        self.isMusicOn = UserDefaults.standard.bool(forKey: "isMusicOn")
        if isMusicOn {
            playMusic()
        }
    }

    func playMusic() {
        guard let url = Bundle.main.url(forResource: "back", withExtension: "mp3") else {
            print("Music file not found!")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1 // Бесконечное воспроизведение
            audioPlayer?.volume = 0.2
            audioPlayer?.play()
        } catch {
            print("Error playing music: \(error.localizedDescription)")
        }
    }

    func stopMusic() {
        audioPlayer?.stop()
    }
}

class SoundPlayer: ObservableObject {
    static let shared = SoundPlayer()
    private var audioPlayer: AVAudioPlayer?

    @Published var isSoundOn: Bool {
        didSet {
            UserDefaults.standard.set(isSoundOn, forKey: "isSoundOn")
        }
    }

    init() {
        // Проверка, был ли это первый запуск
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
        if isFirstLaunch {
            UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
            UserDefaults.standard.set(true, forKey: "isSoundOn") // Звуки включены по умолчанию
        }

        // Загружаем состояние звуков из UserDefaults
        self.isSoundOn = UserDefaults.standard.bool(forKey: "isSoundOn")
    }

    func playSound(for sound: String) {
        // Проверяем, включены ли звуки
        if isSoundOn {
            guard let url = Bundle.main.url(forResource: sound, withExtension: "mp3") else {
                print("Sound file not found!")
                return
            }
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.volume = 0.2
                audioPlayer?.play()
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }
    
    
}



struct MailComposeView: UIViewControllerRepresentable {
    @Binding var isShowing: Bool
    let subject: String
    let recipientEmail: String
    let textBody: String
    var onComplete: ((MFMailComposeResult, Error?) -> Void)?
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailComposer = MFMailComposeViewController()
        mailComposer.setSubject(subject)
        mailComposer.setToRecipients([recipientEmail])
        mailComposer.setMessageBody(textBody, isHTML: false)
        mailComposer.mailComposeDelegate = context.coordinator
        return mailComposer
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        let parent: MailComposeView
        
        init(_ parent: MailComposeView) {
            self.parent = parent
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            parent.isShowing = false
            parent.onComplete?(result, error)
        }
    }
}
