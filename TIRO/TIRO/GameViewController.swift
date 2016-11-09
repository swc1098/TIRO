//
//  GameViewController.swift
//  TIRO
//
//  Created by student on 11/9/16.
//  Copyright © 2016 swc1098. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            
            loadLevel()
            
            
            setNotifcations()
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            self.becomeFirstResponder()
        }
    }
    
    func setNotifcations(){
        NotificationCenter.default.addObserver(self, selector: #selector(didActive), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    func willResign(){
        //gameScene?.gameIsPaused = true
    }
    
    func didActive(){
        if let view = self.view as! SKView? {
           let scene = view.scene as? GameScene
           scene?.gameIsPaused = true
        }
    }

    override var shouldAutorotate: Bool {
        return false
    }
    
    func loadLevel() {
        // Load the SKScene from 'GameScene.sks'
        if let scene = SKScene(fileNamed: "GameScene") {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            
            // Present the scene
            if let view = self.view as! SKView? {
                view.presentScene(scene)
            }
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
