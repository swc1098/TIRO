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
            GameScene.currentlevel = 5
            perform(#selector(loadLevel), with: nil, afterDelay: 0.5)
        }
        if(self.name == "GameOver"){
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
}
