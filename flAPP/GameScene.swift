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
    
    override func didMove(to view: SKView) {
        makeBrick()
        createBackground()
    }
    
    func makeBrick() {
        brick = SKSpriteNode(color: UIColor.blue, size: CGSize(width: 100, height: 300))
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
            skyBackground.position = CGPoint(x: 0, y: skyBackground.size.height * CGFloat(i))
            addChild(skyBackground)
            let moveLeft = SKAction.moveBy(x: -skyBackground.size.width, y: 0, duration: 20)
            let moveReset = SKAction.moveBy(x: skyBackground.size.width, y: 0, duration: 0)
            let moveLoop = SKAction.sequence([moveLeft, moveReset])
            let moveForever = SKAction.repeatForever(moveLoop)
            skyBackground.run(moveForever)
            
        }
    }
    
}


















