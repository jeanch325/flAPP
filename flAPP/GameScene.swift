//
//  GameScene.swift
//  flAPP
//
//  Created by Jean Cho on 7/13/18.
//  Copyright © 2018 Jean Cho. All rights reserved.
//hi

import SpriteKit
import GameplayKit
import AVFoundation
import UIKit


class GameScene: SKScene, SKPhysicsContactDelegate{
    //var viewController: GameViewController?
    var ball = SKShapeNode()
    var bottomBrick = SKSpriteNode()
    var topBrick = SKSpriteNode()
    let wait = SKAction.wait(forDuration: 4.0) //change countdown speed here
    var height = 300
    var centerTop = 50
    var centerBottom = 100
    let displaySize: CGRect = UIScreen.main.bounds
    var pointsLabel = SKLabelNode()
    var number = 0
    var startButton = SKLabelNode()
    var sequence = SKAction() //was declared inside of moveBricks()
    var youLose = SKLabelNode()
    var segueDelegate: GameSegueDelegate?
    var hasBeenTapped = false
    
    
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        createBackground()
        makeBall()
        createStartButton()
        //moveBricks()
        makePoints()
        
    }
    
    func makeBottomBrick() {
        let displayHeight = self.displaySize.height
        var heightsBottom = CGFloat(height*Int(displayHeight)/100)
        bottomBrick = SKSpriteNode(color: .blue, size: CGSize(width: 100, height: heightsBottom))
        //bottomBrick.zPosition = 1
        centerBottom = Int(heightsBottom)/2
        bottomBrick.position = CGPoint(x: frame.maxX + 50, y: frame.minY + CGFloat(centerBottom))
        bottomBrick.name = "bottomBrick"
        bottomBrick.physicsBody = SKPhysicsBody(rectangleOf: bottomBrick.size)
        bottomBrick.physicsBody?.isDynamic = false
        //bottomBrick.zPosition = 4
        addChild(bottomBrick)
    }
    
    func makeTopBrick() {
        //let displayWidth = self.displaySize.width
        let displayHeight = self.displaySize.height
        var heightsTop = CGFloat((70 - height)*Int(displayHeight)/100)
        topBrick = SKSpriteNode(color: .blue, size: CGSize(width: 100, height: heightsTop))
        //topBrick.zPosition = 1
        centerTop = Int(heightsTop)/2
        topBrick.position = CGPoint(x: frame.maxX + 50, y: frame.maxY - CGFloat(centerTop))
        topBrick.name = "topBrick"
        topBrick.physicsBody = SKPhysicsBody(rectangleOf: topBrick.size)
        topBrick.physicsBody?.isDynamic = false
        //topBrick.zPosition = 4
        addChild(topBrick)
    }
    
    func moveBricks(){
        for i in 1...100{
            let pick = arc4random_uniform(41)+30
            let displayWidth = self.displaySize.width
            let displayHeight = self.displaySize.height
            var heightsBottom = CGFloat(height*Int(displayHeight)/100)
            var heightsTop = CGFloat((90 - height)*Int(displayHeight)/100)
            height = Int(pick)
            centerBottom = Int(heightsBottom)/2
            centerTop = Int(heightsTop)/2
            makeBottomBrick()
            makeTopBrick()
            let moveBottomLeft = SKAction.move(to: CGPoint(x: frame.minX - 50,y: frame.minY + CGFloat(centerBottom)), duration:4.0)
            let wait1 = SKAction.wait(forDuration: 3.0*Double(i)) //change countdown speed here
            sequence = SKAction.sequence([wait1, moveBottomLeft]) //was declared here
            bottomBrick.run(sequence)
            let moveTopLeft = SKAction.move(to: CGPoint(x: frame.minX - 50,y: frame.maxY - CGFloat(centerTop)), duration:4.0)
            let wait2 = SKAction.wait(forDuration: 3.0*Double(i)) //change countdown speed here
            let otherSequence = SKAction.sequence([wait1, moveTopLeft])
            topBrick.run(otherSequence)
        }
    }
    
    func createBackground() {
        let sky = SKTexture(imageNamed: "sky")
        for i in 0...1 {
            let skyBackground = SKSpriteNode(texture: sky)
            skyBackground.zPosition = -5
            skyBackground.size.height = frame.height
            skyBackground.size.width = frame.width * 2
            skyBackground.position = CGPoint(x: skyBackground.size.width * CGFloat(i), y: 0)
            addChild(skyBackground)
            let moveLeft = SKAction.moveBy(x: -skyBackground.size.width, y: 0, duration: 20)
            let moveReset = SKAction.moveBy(x: skyBackground.size.width, y: 0, duration: 0)
            let moveLoop = SKAction.sequence([moveLeft, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)
            skyBackground.run(moveForever)
            
        }
    }

    
    
    
//    let sky = SKTexture(imageNamed: "sky")
//    for i in 0...1 {
//    let skyBackground = SKSpriteNode(texture: sky)
//    skyBackground.zPosition = -5
//    skyBackground.size.height = frame.height
//    skyBackground.size.width = frame.width * 2
//    skyBackground.position = CGPoint(x: skyBackground.size.width * CGFloat(i), y: 0)
//    addChild(skyBackground)
//    let moveLeft = SKAction.moveBy(x: -skyBackground.size.width, y: 0, duration: 20)
//    let moveReset = SKAction.moveBy(x: skyBackground.size.width, y: 0, duration: 0)
//    let moveLoop = SKAction.sequence([moveLeft, moveReset])
//    let moveForever = SKAction.repeatForever(moveLoop)
//    skyBackground.run(moveForever)
//
//    }
    
    
    
    func makeBall() {
        ball = SKShapeNode(circleOfRadius: 10)
        //ball.zPosition = 1
        ball.position = CGPoint(x: frame.midX - 100, y: frame.midY)
        ball.strokeColor = .black
        ball.fillColor = .red
        ball.name = "ball"
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 5.6)
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.usesPreciseCollisionDetection = true //was false
//        ball.physicsBody?.categoryBitMask = 0
//        ball.physicsBody?.collisionBitMask = 0
        ball.physicsBody?.friction = 0
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.isDynamic = true
        //was not here:
                    ball.physicsBody?.restitution = 0
                    ball.physicsBody?.linearDamping = 1
        ball.physicsBody?.contactTestBitMask = (ball.physicsBody?.collisionBitMask)!
        let range = SKRange(lowerLimit: frame.minY, upperLimit: frame.maxY)
        let lockToCenter = SKConstraint.positionX(range, y: range)
        ball.constraints = [lockToCenter]
        
        
        addChild(ball)
        
        
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
    }
    
    func makePoints() {
        pointsLabel.text = "Points: \(number)"
        pointsLabel.zPosition = 5
        pointsLabel.fontSize = 30
        pointsLabel.position = CGPoint(x: -150, y: -350)
        pointsLabel.fontColor = .black
        pointsLabel.color = .white
        addChild(pointsLabel)
        
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
                ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 4)) //dx = x magnitude, dy = y magnitude
                if hasBeenTapped == false {
                    moveBricks()
                }
            hasBeenTapped = true
            }
            
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
        }
        for startButtonTouch in touches {
            startButton.isHidden = true
            if startButton.isHidden == true {
                
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("a: \(contact.bodyA.node?.name)")
        print("b: \(contact.bodyB.node?.name)")
        print("brick position : \(topBrick.position)")
        print("ball position: \(ball.position)")
        
        if contact.bodyA.node?.name == "bottomBrick" || contact.bodyB.node?.name == "bottomBrick" || contact.bodyA.node?.name == "topBrick" || contact.bodyB.node?.name == "topBrick" {
            pointsLabel.text = "You lose"
            print("You lose!")
            ball.removeFromParent() //removes ball from game
                //restart()
//            self.viewController?.performSegue(withIdentifier: "gameOver", sender: nil)
            segueDelegate?.callSegue()
            
            
            
        }
            
        else {
//          where sanya needs to put the fricking restart function
        }
    }
//
//    func restart() {
//        print("restart")
//        removeAllChildren()
//        youLoseText()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//           self.youLose.removeFromParent()
//            self.makeBall()
//            self.createStartButton()
//            self.moveBricks()
//            self.makePoints()
//        }
//    }
//
//    func youLoseText() {
//        youLose.position = CGPoint(x: frame.midX, y: frame.midY)
//        youLose.text = "You Lose!"
//        youLose.fontColor = .white
//        youLose.fontName = "Marker Felt"
//        youLose.fontSize = 60
//        youLose.name = "you lose"
//        youLose.zPosition = 2
//        addChild(youLose)
//    }
    
    
    
    
    
    
}

// just to check if it works



















