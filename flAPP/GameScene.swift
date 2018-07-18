//
//  GameScene.swift
//  flAPP
//
//  Created by Jean Cho on 7/13/18.
//  Copyright © 2018 Jean Cho. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation


class GameScene: SKScene {
    
    var bottomBrick = SKSpriteNode()
    var topBrick = SKSpriteNode()
    var ball = SKShapeNode()
    let wait = SKAction.wait(forDuration: 4.0) //change countdown speed here
    var heightsArray = [30, 40, 50, 60, 70]
    var height = 300
    var centerTop = 50
    let displaySize: CGRect = UIScreen.main.bounds
     var pointsLabel = SKLabelNode()
    var number = 0
    var audioPlayer = AVAudioPlayer()
    var centerBottom = 100
   var startButton = SKLabelNode()
    
    
  
    
    
    override func didMove(to view: SKView) {
        createBackground()
         makeBall()
        makePoints()
        let sound = NSURL(fileURLWithPath: Bundle.main.path(forResource:"background", ofType: "mp3")!)
        try? audioPlayer = AVAudioPlayer(contentsOf: sound as URL)
        audioPlayer.prepareToPlay()
         audioPlayer.numberOfLoops = -1
        audioPlayer.play()
        moveBricks()
        createStartButton()
        
     
        
       
//        let sound = SKAction.playSoundFileNamed("background.m4a", waitForCompletion: false)
//        run(sound)
        
    }
    
//    func makeBottomBrick() {
//        let displayWidth = self.displaySize.width
//        let displayHeight = self.displaySize.height
//        var heights = CGFloat(height*Int(displayWidth)/100)
//        bottomBrick = SKSpriteNode(color: UIColor.blue, size: CGSize(width: 100, height: heights))
//        print(heights)
//        bottomBrick.zPosition = 1
//        center = height/2
//        bottomBrick.position = CGPoint(x: frame.maxX + 50, y: frame.minY + CGFloat(center))
//        bottomBrick.name = "bottomBrick"
//        bottomBrick.physicsBody = SKPhysicsBody(rectangleOf: bottomBrick.size)
//        bottomBrick.physicsBody?.isDynamic = false
//        bottomBrick.zPosition = 4
//        addChild(bottomBrick)
//    }
//
//    func makeTopBrick() {
//        topBrick = SKSpriteNode(color: .blue, size: CGSize(width: 50, height: 20))
//        topBrick.zPosition = 1
//        topBrick.position = CGPoint(x: frame.midX, y: frame.maxY - 30)
//        topBrick.name = "topBrick"
//        topBrick.physicsBody = SKPhysicsBody(rectangleOf: bottomBrick.size)
//        topBrick.physicsBody?.isDynamic = false
//        addChild(topBrick)
//    }
//
//    func makeBottomBricks(){
//        for i in 1...10{
//            let displayWidth = self.displaySize.width
//            let displayHeight = self.displaySize.height
//            var heights = CGFloat(height*Int(displayWidth)/100)
//            height = heightsArray[i % 5]
//            center = Int(heights)/2
//            print("height: \(height), center:\(center)")
//            makeBottomBrick()
//            let moveBottomLeft = SKAction.move(to: CGPoint(x: frame.minX - 50,y: frame.minY + CGFloat(center)), duration:4.0)
//            let wait1 = SKAction.wait(forDuration: 4.0*Double(i)) //change countdown speed here
//            let sequence = SKAction.sequence([wait1, moveBottomLeft])
//            bottomBrick.run(sequence)
//        }
//    }
    
    
    func makeBottomBrick() {
        let displayHeight = self.displaySize.height
        var heightsBottom = CGFloat(height*Int(displayHeight)/100)
        bottomBrick = SKSpriteNode(color: UIColor.red, size: CGSize(width: 100, height: heightsBottom))
        bottomBrick.zPosition = 1
        centerBottom = Int(heightsBottom)/2
        bottomBrick.position = CGPoint(x: frame.maxX + 50, y: frame.minY + CGFloat(centerBottom))
        bottomBrick.name = "bottomBrick"
        bottomBrick.physicsBody = SKPhysicsBody(rectangleOf: bottomBrick.size)
        bottomBrick.physicsBody?.isDynamic = false
        bottomBrick.zPosition = 4
        addChild(bottomBrick)
    }
    
    func makeTopBrick() {
        let displayWidth = self.displaySize.width
        let displayHeight = self.displaySize.height
        var heightsTop = CGFloat((90 - height)*Int(displayHeight)/100)
        topBrick = SKSpriteNode(color: .blue, size: CGSize(width: 100, height: heightsTop))
        topBrick.zPosition = 1
        centerTop = Int(heightsTop)/2
        topBrick.position = CGPoint(x: frame.maxX + 50, y: frame.maxY - CGFloat(centerTop))
        topBrick.name = "topBrick"
        topBrick.physicsBody = SKPhysicsBody(rectangleOf: bottomBrick.size)
        topBrick.physicsBody?.isDynamic = false
        topBrick.zPosition = 4
        addChild(topBrick)
    }
    
    func moveBricks(){
        for i in 1...10{
            let displayWidth = self.displaySize.width
            let displayHeight = self.displaySize.height
            var heightsBottom = CGFloat(height*Int(displayHeight)/100)
            var heightsTop = CGFloat((85 - height)*Int(displayHeight)/100)
            height = heightsArray[i % 5]
            centerBottom = Int(heightsBottom)/2
            centerTop = Int(heightsTop)/2
            makeBottomBrick()
            makeTopBrick()
            let moveBottomLeft = SKAction.move(to: CGPoint(x: frame.minX - 50,y: frame.minY + CGFloat(centerBottom)), duration:4.0)
            let wait1 = SKAction.wait(forDuration: 4.0*Double(i)) //change countdown speed here
            let sequence = SKAction.sequence([wait1, moveBottomLeft])
            bottomBrick.run(sequence)
            let moveTopLeft = SKAction.move(to: CGPoint(x: frame.minX - 50,y: frame.maxY - CGFloat(centerTop)), duration:4.0)
            let wait2 = SKAction.wait(forDuration: 4.0*Double(i)) //change countdown speed here
            let otherSequence = SKAction.sequence([wait1, moveTopLeft])
            topBrick.run(otherSequence)
        }
    }

    
        func createBackground() {
            let sky = SKTexture(imageNamed: "sky")
            for i in 0...1 {
                let skyBackground = SKSpriteNode(texture: sky)
                skyBackground.zPosition = 0
                skyBackground.size.height = frame.height
                skyBackground.size.width = frame.height
                skyBackground.position = CGPoint(x: skyBackground.size.width * CGFloat(i), y: 0)
                addChild(skyBackground)
                let moveLeft = SKAction.moveBy(x: -skyBackground.size.width, y: 0, duration: 20)
                let moveReset = SKAction.moveBy(x: skyBackground.size.width, y: 0, duration: 0)
                let moveLoop = SKAction.sequence([moveLeft, moveReset])
                let moveForever = SKAction.repeatForever(moveLoop)
                skyBackground.run(moveForever)
                
            }
            
            
        }
    
//    func createBackground() {
//        let sky = SKTexture(imageNamed: "sky")
//        for i in 0...1 {
//            let skyBackground = SKSpriteNode(texture: sky)
//            skyBackground.zPosition = -1
//            skyBackground.position = CGPoint(x: 0, y: skyBackground.size.height * CGFloat(i))
//            addChild(skyBackground)
//            let moveLeft = SKAction.moveBy(x: -skyBackground.size.width, y: 0, duration: 20)
//            let moveReset = SKAction.moveBy(x: skyBackground.size.width, y: 0, duration: 0)
//            let moveLoop = SKAction.sequence([moveLeft, moveReset])
//            let moveForever = SKAction.repeatForever(moveLoop)
//            skyBackground.run(moveForever)
//
//        }
//        }
    
    
    func makeBall() {
        ball = SKShapeNode(circleOfRadius: 10)
        ball.zPosition = 1
        ball.position = CGPoint(x: frame.midX - 100, y: frame.midY)
        ball.strokeColor = .black
        ball.fillColor = .red
        ball.name = "ball"
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 5.5)
        
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.usesPreciseCollisionDetection = true
        ball.physicsBody?.friction = 0
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.restitution = 0
        ball.physicsBody?.linearDamping = 1
        ball.physicsBody?.contactTestBitMask = (ball.physicsBody?.collisionBitMask)!

        addChild(ball)
        
    }
    func makePoints() {
    pointsLabel.text = "Points: \(number)"
        pointsLabel.fontSize = 30
        pointsLabel.position = CGPoint(x: -150, y: -350)
        pointsLabel.fontColor = .black
        addChild(pointsLabel)
    }
    
    func restart (){
        makeBall()
        number = 0
        startButton.isHidden = false
        audioPlayer.play()
        
        
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //when you first touch the stuff
        for touch in touches {
            let location = touch.location(in: self)
        }
        
        //start button
        for startButtonTouch in touches {
            startButton.isHidden = true
            if startButton.isHidden == true {
                ball.physicsBody?.affectedByGravity = true
                ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 5)) //dx = x magnitude, dy = y magnitude
            }
            
        }
        
    }
    
    func createStartButton() {
        startButton.position = CGPoint(x: frame.midX, y: frame.midY)
        startButton.text = "Tap to Start"
        startButton.color = .clear
        startButton.fontColor = .black
        startButton.fontName = "Marker Felt"
        startButton.fontSize = 40
        startButton.name = "start button"
        startButton.zPosition = 2
        
        addChild(startButton)

    
        func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            ball.position.x = location.x //only x so the paddle can't move veritcally
            topBrick.position.x = location.x
            bottomBrick.position.x = location.x
        }
        for startButtonTouch in touches {
            startButton.isHidden = true
            if startButton.isHidden == true {
                
            }
        }
    }

    
    
        
    
    

  
}
}








    
    
    
    











