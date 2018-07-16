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
    
    var bottomBrick = SKSpriteNode()
    var topBrick = SKSpriteNode()
    var ball = SKShapeNode()
    let wait = SKAction.wait(forDuration: 4.0) //change countdown speed here
    var heightsArray = [30, 40, 50, 60, 70]
    var height = 300
    var center = 50
    let displaySize: CGRect = UIScreen.main.bounds
    
    
    override func didMove(to view: SKView) {
        createBackground()
        makeBall()
        makeBottomBricks()
        makeTopBrick()
    }
    
    func makeBottomBrick() {
        let displayWidth = self.displaySize.width
        let displayHeight = self.displaySize.height
        var heights = CGFloat(height*Int(displayWidth)/100)
        bottomBrick = SKSpriteNode(color: UIColor.blue, size: CGSize(width: 100, height: heights))
        print(heights)
        bottomBrick.zPosition = 1
        center = height/2
        bottomBrick.position = CGPoint(x: frame.maxX + 50, y: frame.minY + CGFloat(center))
        bottomBrick.name = "bottomBrick"
        bottomBrick.physicsBody = SKPhysicsBody(rectangleOf: bottomBrick.size)
        bottomBrick.physicsBody?.isDynamic = false
        bottomBrick.zPosition = 4
        addChild(bottomBrick)
    }
    
    func makeTopBrick() {
        topBrick = SKSpriteNode(color: .blue, size: CGSize(width: 50, height: 20))
        topBrick.zPosition = 1
        topBrick.position = CGPoint(x: frame.midX, y: frame.maxY - 30)
        topBrick.name = "topBrick"
        topBrick.physicsBody = SKPhysicsBody(rectangleOf: bottomBrick.size)
        topBrick.physicsBody?.isDynamic = false
        addChild(topBrick)
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
    
    func makeBottomBricks(){
        for i in 1...10{
            let displayWidth = self.displaySize.width
            let displayHeight = self.displaySize.height
            var heights = CGFloat(height*Int(displayWidth)/100)
            height = heightsArray[i % 5]
            center = Int(heights)/2
            print("height: \(height), center:\(center)")
            makeBottomBrick()
            let moveBottomLeft = SKAction.move(to: CGPoint(x: frame.minX - 50,y: frame.minY + CGFloat(center)), duration:4.0)
            let wait1 = SKAction.wait(forDuration: 4.0*Double(i)) //change countdown speed here
            let sequence = SKAction.sequence([wait1, moveBottomLeft])
            bottomBrick.run(sequence)
        }
        
        
    }
}


















