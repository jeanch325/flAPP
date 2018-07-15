//
//  GameScene.swift
//  flAPP
//
//  Created by Jean Cho on 7/13/18.
//  Copyright © 2018 Jean Cho. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var brick = SKSpriteNode()
    var ball = SKShapeNode()
    var startButton = SKLabelNode()
    
    
    
    override func didMove(to view: SKView) {
        makeBrick()
        createBackground()
        makeBall()
        let moveBottomLeft = SKAction.move(to: CGPoint(x: frame.minX,y: frame.minY + 50), duration:2.0)
        brick.run(moveBottomLeft)
        
    }
    
    func makeBrick() {
        brick = SKSpriteNode(color: UIColor.blue, size: CGSize(width: 100, height: 300))
        brick.zPosition = 1
        brick.position = CGPoint(x: frame.midX, y: frame.minY + 50)
        brick.name = "brick"
        brick.physicsBody = SKPhysicsBody(rectangleOf: brick.size)
        brick.physicsBody?.isDynamic = false
        addChild(brick)
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
        func makeStartButton() {
            startButton.position = CGPoint(x: frame.midX, y: frame.midY)
            startButton.text = "Tap to Start"
            startButton.color = .clear
            startButton.fontColor = .white
            startButton.fontSize = 40
            startButton.name = "start button"
            startButton.fontName = "Marker Felt"
            
            addChild(startButton)
        }
        
        
    }
    func makeBall() {
        ball = SKShapeNode(circleOfRadius: 10)
        ball.zPosition = 1
        ball.position = CGPoint(x: frame.midX - 100, y: frame.midY)
        ball.strokeColor = .black
        ball.fillColor = .red
        ball.name = "ball"
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        ball.physicsBody?.isDynamic = false
        ball.physicsBody?.usesPreciseCollisionDetection = true
        ball.physicsBody?.friction = 0
        ball.physicsBody?.affectedByGravity = true
        ball.physicsBody?.restitution = 1
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.contactTestBitMask = (ball.physicsBody?.collisionBitMask)!
        
        addChild(ball)
        
    }
    
    
    
    
    
    
}


















