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
    var heightsArray = [100, 200, 300, 400]
    var height = 300
    
    
    
 
    
    
    override func didMove(to view: SKView) {
        createBackground()
        makeBall()
        makeBottomBricks()
        makeTopBrick()
    }
    
    func makeBottomBrick() {
        bottomBrick = SKSpriteNode(color: UIColor.blue, size: CGSize(width: 100, height: height + 400))
        bottomBrick.zPosition = 1
        bottomBrick.position = CGPoint(x: frame.maxX + 50, y: frame.minY + 50)
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
        
    }
    
    func makeBottomBricks(){
        for i in 1...10{
            height = heightsArray[i % 4]
            print("height: \(height)")
            makeBottomBrick()
            let moveBottomLeft = SKAction.move(to: CGPoint(x: frame.minX - 50,y: frame.minY + 50), duration:4.0)
            let wait1 = SKAction.wait(forDuration: 4.0*Double(i)) //change countdown speed here
            let sequence = SKAction.sequence([wait1, moveBottomLeft])
            bottomBrick.run(sequence)
        }
        
        
    }
    
    

    
    
}


















