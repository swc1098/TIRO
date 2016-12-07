//
//  WinScene.swift
//  TIRO
//
//  Created by student on 11/16/16.
//  Copyright © 2016 swc1098. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class TransScene: SKScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(self.name == "Win"){
            GameScene.currentlevel += 1
            perform(#selector(loadLevel), with: nil, afterDelay: 0.5)
        }
        if(self.name == "Lose"){
            perform(#selector(loadLevel), with: nil, afterDelay: 0.5)
        }
        if(self.name == "Home"){
            let playButton = childNode(withName:"play") as! SKLabelNode
            let instructButton = childNode(withName:"instructions") as! SKLabelNode
            let creditButton = childNode(withName:"credits") as! SKLabelNode
            
            for touch: AnyObject in touches{
                let location = touch.location(in:self)
                if playButton.contains(location){
                    GameScene.currentlevel = 3
                    perform(#selector(loadLevel), with: nil, afterDelay: 0.5)
                    return;
                }
                if instructButton.contains(location){
                    perform(#selector(loadInstruct), with: nil, afterDelay: 0.5)
                }
                if creditButton.contains(location){
                    perform(#selector(loadCredits), with: nil, afterDelay: 0.5)
                }
                return
            }
        }
        if(self.name == "GameOver"){
            GameScene.currentlevel = 1
            perform(#selector(loadHome), with: nil, afterDelay: 0.5)
        }
        if(self.name == "Instructions")
        {
            GameScene.currentlevel = 1
            perform(#selector(loadHome), with: nil, afterDelay: 0.5)
        }
        if(self.name == "Credits")
        {
            GameScene.currentlevel = 1
            perform(#selector(loadHome), with: nil, afterDelay: 0.5)
        }
    }
    
    func loadLevel() {
        let scene = GameScene(fileNamed: "Level\(GameScene.currentlevel)")
        scene!.scaleMode = scaleMode
        view?.presentScene(scene)
    }
    
    func loadHome() {
        let scene = GameScene(fileNamed: "Home")
        scene!.scaleMode = scaleMode
        view?.presentScene(scene)
    }
    
    func loadInstruct() {
        let scene = GameScene(fileNamed: "Instructions")
        scene!.scaleMode = scaleMode
        view?.presentScene(scene)
    }
    
    func loadCredits() {
        let scene = GameScene(fileNamed: "Credits")
        scene!.scaleMode = scaleMode
        view?.presentScene(scene)
    }
}
