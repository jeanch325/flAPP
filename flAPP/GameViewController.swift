//
//  GameViewController.swift
//  flAPP
//
//  Created by Jean Cho on 7/13/18.
//  Copyright © 2018 Jean Cho. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

protocol GameSegueDelegate {
    func callSegue()
}

class GameViewController: UIViewController, GameSegueDelegate {
    
    var myGameScene: GameScene!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                myGameScene = scene as! GameScene
                myGameScene.segueDelegate = self
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .resizeFill
                // Present the scene
                view.presentScene(scene)
                
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
           
        }
    }
    
    func callSegue() {
        performSegue(withIdentifier: "gameOver", sender: nil)
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("This actually worked!")
    }
}
