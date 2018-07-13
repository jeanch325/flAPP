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
            skyBackground.zPosition = -1
            skyBackground.position = CGPoint(x: 0, y: skyBackground.size.height * CGFloat(i))
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
        addChild(ball)
        
    }
    
    
    
    
//    let jumpUpAction = SKAction.moveByX(0, y:20 duration:0.2)
//    let jumpSequence = SKAction.sequence([jumpUpAction])
//    player.runAction(jumpSequence)
    
    
    
    
    
    
    
}


















