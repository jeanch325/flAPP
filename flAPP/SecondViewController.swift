//
//  SecondViewController.swift
//  flAPP
//
//  Created by Jean Cho on 7/18/18.
//  Copyright © 2018 Jean Cho. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController{
    
    var data = 0
    @IBOutlet var yourScore: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        yourScore.setTitle("Score: \(data)! Tap to restart", for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
