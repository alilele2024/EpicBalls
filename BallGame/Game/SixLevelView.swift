//
//  SixLevelView.swift
//  BallGame
//
//  Created by D K on 24.12.2024.
//

import SwiftUI
import SpriteKit

#Preview {
    SixLevelView()
}

struct SixLevelView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var gameScene = SixGameSceneWrapper()
    @StateObject private var soundPlayer = SoundPlayer.shared
    
    @State private var gameMessage: String = ""
    @State private var lives: Int = 3
    @State private var isGameOver: Bool = false
    @State private var isMissAlertShown = false
    @State private var isHitAlertShown = false
    @State private var score = 0
    @State private var isCompleted = false

    
    var body: some View {
        ZStack {
            SpriteView(scene: gameScene.scene)
                .edgesIgnoringSafeArea(.all)
                .gesture(
                    DragGesture(minimumDistance: 20)
                        .onEnded { value in
                            let dx = value.translation.width
                            let dy = value.translation.height
                            let impulseVector = CGVector(dx: dx, dy: -dy)
                            gameScene.scene.launchBottomBall(with: impulseVector)
                        }
                )
                .blur(radius: isGameOver ? 5 : 0)
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                    }
                    
                    Spacer()
                    
                    ForEach(0..<lives, id: \.self) { index in
                        Image("heart")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                }
                .padding(.horizontal)
                
                
                Spacer()
            }
            
            VStack {
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.system(size: 32, weight: .black))
                Spacer()
            }
            .padding(.top, 50)
        }
        .background {
            Color.black
                .ignoresSafeArea()
        }
        .onReceive(gameScene.$gameEvent, perform: { event in
            handleGameEvent(event)
        })
        .overlay {
            LabelAlert(isAppeared: $isMissAlertShown, image: "missLabel")
            LabelAlert(isAppeared: $isHitAlertShown, image: "hitLabel")
        }
        .overlay {
            if isGameOver {
                EndGameAlert(score: "\(score)", isCompleted: isCompleted) {
                    withAnimation {
                        score = 0
                        restartGame()
                    }
                } close: {
                    dismiss()
                }
            }
        }
    }
    
    private func handleGameEvent(_ event: SixGameEvent?) {
        switch event {
        case .hitTopBall:
            isHitAlertShown.toggle()
            soundPlayer.playSound(for: "hit")
            score += 50
        case .hitStripe:
            lives -= 1
            print("miss")
            isMissAlertShown.toggle()
            soundPlayer.playSound(for: "miss")
            if lives <= 0 {
                endGame(with: "over")
            }
        case .allBallsCleared:
            endGame(with: "complete")
        case .none:
            break
        case .gameOver:
            print("OVER")
        case .miss:
            print("miss")
        }
    }
    
    private func endGame(with message: String) {
        gameMessage = message
        if message == "complete" {
            isCompleted = true
            UserDefaults.standard.setValue(true, forKey: "sixLevelCompleted")
        }
        isGameOver = true
        gameScene.scene.isPaused = true
    }
    
    private func restartGame() {
        lives = 3
        isGameOver = false
        gameMessage = ""
        gameScene.scene.resetGame()
    }
    
    private func missAlert() {
        
    }
}

class SixGameSceneWrapper: ObservableObject {
    @Published var scene: SixGameScene
    @Published var gameEvent: SixGameEvent? = nil
    
    init() {
        scene = SixGameScene()
        scene.size = UIScreen.main.bounds.size
        scene.scaleMode = .resizeFill
        scene.gameEventHandler = { [weak self] event in
            self?.gameEvent = event
        }
    }
}

enum SixGameEvent {
    case hitTopBall
    case hitStripe
    case allBallsCleared
    case miss
    case gameOver
}

class SixGameScene: SKScene, SKPhysicsContactDelegate {
    var gameEventHandler: ((SixGameEvent) -> Void)?
    
    private var currentTopBallSpeed: CGFloat = 200
    private let maxTopBallSpeed: CGFloat = 400
    private let speedIncrement: CGFloat = 50
    
    private var bottomBall: SKSpriteNode!
    private var topBalls: [SKSpriteNode] = []
    private let ballRadius: CGFloat = 20
    private let defaultBottomBallPosition: CGPoint = CGPoint(x: UIScreen.main.bounds.width / 2, y: 150)
    private var ballInMotion = false
    private var resettingBall = false
    
    private var stripe: SKSpriteNode!
        
    override func didMove(to view: SKView) {
        backgroundColor = .white
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = .zero
        
        createBackground()
        createBottomBall()
        createTopBalls()
        createStripe()
        moveStripe()
        moveTopBalls()
    }
    
    private func createBackground() {
        let background = SKSpriteNode(imageNamed: "bg") // Название файла вашего изображения
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.size = size // Растянуть фон на весь экран
        background.zPosition = -1 // Убедитесь, что фон за другими элементами
        addChild(background)
    }
    
    private func createStripe() {
        let texture = SKTexture(imageNamed: "line")
        stripe = SKSpriteNode(texture: texture, size: CGSize(width: 100, height: 60))
       // stripe = SKSpriteNode(color: .red, size: CGSize(width: 100, height: 10))
        stripe.position = CGPoint(x: frame.midX, y: frame.height / 2.6)
        stripe.name = "stripe"
        stripe.physicsBody = SKPhysicsBody(rectangleOf: stripe.size)
        stripe.physicsBody?.isDynamic = false
        stripe.physicsBody?.categoryBitMask = 4
        stripe.physicsBody?.collisionBitMask = 0
        stripe.physicsBody?.contactTestBitMask = 1
        addChild(stripe)
    }
    
    private func moveStripe() {
        let moveRight = SKAction.moveTo(x: frame.width - stripe.size.width / 2, duration: 1)
        let moveLeft = SKAction.moveTo(x: stripe.size.width / 2, duration: 1)
        let sequence = SKAction.sequence([moveRight, moveLeft])
        stripe.run(SKAction.repeatForever(sequence))
    }

    
    private func createBottomBall() {
        // Удаляем старый мяч, если он есть
        if bottomBall != nil {
            bottomBall.removeFromParent()
        }

        // Чтение текстуры из UserDefaults
        let userDefaults = UserDefaults.standard
        let textureName = userDefaults.string(forKey: "ball") ?? "el6"

        let texture = SKTexture(imageNamed: textureName)
        bottomBall = SKSpriteNode(texture: texture)
        bottomBall.size = CGSize(width: ballRadius * 3, height: ballRadius * 3)
        bottomBall.position = defaultBottomBallPosition
        bottomBall.name = "bottomBall"
        bottomBall.physicsBody = createPhysicsBody()
        addChild(bottomBall)
    }


    
    private func createTopBalls() {
        let positions = [size.width * 0.0, size.width * 0.15, size.width * 0.30, size.width * 0.45, size.width * 0.55]
        let textures = ["el1", "el2", "el3", "el4", "el2"] // Имена ваших изображений

        for (index, posX) in positions.enumerated() {
            let textureName = textures[index % textures.count] // Циклический выбор текстур
            let ball = SKSpriteNode(imageNamed: textureName)
            ball.size = CGSize(width: ballRadius * 3, height: ballRadius * 3)
            ball.position = CGPoint(x: posX, y: size.height - ballRadius - 170)
            ball.name = "topBall"
            ball.physicsBody = SKPhysicsBody(circleOfRadius: ballRadius)
            ball.physicsBody?.isDynamic = false
            ball.physicsBody?.categoryBitMask = 2
            ball.physicsBody?.collisionBitMask = 0
            ball.physicsBody?.contactTestBitMask = 1
            addChild(ball)
            topBalls.append(ball)
        }
    }


    private func moveTopBalls() {
        let screenWidth = size.width
        let screenHeight = size.height
        let leftMargin = ballRadius
        let rightMargin = screenWidth - ballRadius
        let verticalStep: CGFloat = 30.0 // Вертикальное смещение между "зигами" и "загами"
        let durationPerSegment: TimeInterval = 0.5 // Время на один горизонтальный отрезок
        let totalVerticalSteps = 1 // Количество вертикальных шагов до смены направления
        
        for (index, ball) in topBalls.enumerated() {
            ball.removeAllActions()
            
            // Начальная позиция
            let startX = leftMargin
            let startY = screenHeight - CGFloat(index + 1) * verticalStep * 2 + -70
            
            // Создаем массив действий для зигзага
            var actions: [SKAction] = []
            var currentY = startY
            var movingDown = true
            
            for _ in 0..<(totalVerticalSteps * 2) { // Вниз и вверх
                let moveRight = SKAction.moveTo(x: rightMargin, duration: durationPerSegment)
                let moveLeft = SKAction.moveTo(x: leftMargin, duration: durationPerSegment)
                let verticalChange = movingDown ? -verticalStep : verticalStep
                
                let moveVertical = SKAction.move(by: CGVector(dx: 0, dy: verticalChange), duration: durationPerSegment / 2)
                
                actions.append(contentsOf: [moveRight, moveVertical, moveLeft, moveVertical])
                
                // Обновляем текущее положение по Y и проверяем, не пора ли сменить направление
                currentY += verticalChange * 2 // 2 изменения за один цикл
                if abs(currentY - startY) >= CGFloat(totalVerticalSteps) * verticalStep {
                    movingDown.toggle()
                }
            }
            
            // Повторяем весь цикл действий бесконечно
            let zigzagSequence = SKAction.sequence(actions)
            let repeatAction = SKAction.repeatForever(zigzagSequence)

            // Устанавливаем начальную позицию мяча
            ball.position = CGPoint(x: startX, y: startY)
            ball.run(repeatAction)
        }
    }


    
    func launchBottomBall(with vector: CGVector) {
        guard !ballInMotion else { return }
        
        ballInMotion = true
        bottomBall.physicsBody?.velocity = .zero
        
        let maxImpulse: CGFloat = 150.0
        let impulseMagnitude = sqrt(vector.dx * vector.dx + vector.dy * vector.dy)
        let scale = min(1.0, maxImpulse / impulseMagnitude)
        let limitedVector = CGVector(dx: vector.dx * scale, dy: vector.dy * scale)
        
        bottomBall.physicsBody?.applyImpulse(limitedVector)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard !resettingBall else { return } // Prevent duplicate resets during simultaneous collisions
        
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        
        var handledCollision = false
        
        if let topBall = (nodeA?.name == "topBall" ? nodeA : nodeB?.name == "topBall" ? nodeB : nil) {
            topBall.removeFromParent()
            topBalls.removeAll { $0 == topBall }
            gameEventHandler?(.hitTopBall)
            
            handledCollision = true
            
            if topBalls.isEmpty {
                gameEventHandler?(.allBallsCleared)
            }
        }
       
        if let stripe = (nodeA?.name == "stripe" ? nodeA : nodeB?.name == "stripe" ? nodeB : nil), !handledCollision {
            gameEventHandler?(.hitStripe)
            handledCollision = true
        }
        
        if handledCollision {
            resetBottomBall()
        }
    }
    
    
    func resetBottomBall() {
        resettingBall = true

        // Проверяем и удаляем существующий bottomBall
        if bottomBall != nil {
            bottomBall.removeFromParent()
            bottomBall = nil
        }
        ballInMotion = false

        // Используем таймер или последовательность действий для создания нового мяча
        let waitAction = SKAction.wait(forDuration: 0.5)
        let createBallAction = SKAction.run { [weak self] in
            guard let self = self else { return }
            
            // Создаем новый мяч, если его все еще нет
            if self.bottomBall == nil {
                self.createBottomBall()
                self.bottomBall.alpha = 0
                
                let fadeInAction = SKAction.fadeIn(withDuration: 0.5)
                self.bottomBall.run(fadeInAction) {
                    self.resettingBall = false
                }
            }
        }

        run(SKAction.sequence([waitAction, createBallAction]))
    }


    
    override func update(_ currentTime: TimeInterval) {
        if ballInMotion && !frame.contains(bottomBall.position) {
            gameEventHandler?(.hitStripe)
            resetBottomBall()
        }
    }
    
    func resetGame() {
        isPaused = false

        // Удаляем старый bottomBall, если он есть
        if bottomBall != nil {
            bottomBall.removeFromParent()
            bottomBall = nil
        }

        // Удаляем старые верхние мячи
        topBalls.forEach { $0.removeFromParent() }
        topBalls.removeAll()

        // Создаем верхние мячи
        createTopBalls()
        moveTopBalls()

        // Создаем нижний мяч, если его еще нет
        if bottomBall == nil {
            createBottomBall()
        }

        // Сбрасываем параметры
        currentTopBallSpeed = 200
        ballInMotion = false
        resetBottomBall()
    }


    
    private func createPhysicsBody() -> SKPhysicsBody {
        let physicsBody = SKPhysicsBody(circleOfRadius: ballRadius)
        physicsBody.isDynamic = true
        physicsBody.restitution = 1.0
        physicsBody.friction = 0.0
        physicsBody.linearDamping = 0.0
        physicsBody.angularDamping = 0.0
        physicsBody.categoryBitMask = 1
        physicsBody.contactTestBitMask = 2 | 4
        physicsBody.collisionBitMask = 0
        return physicsBody
    }
}
