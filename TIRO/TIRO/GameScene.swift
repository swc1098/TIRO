//
//  GameScene.swift
//  TIRO
//
//  Created by student on 11/9/16.
//  Copyright © 2016 swc1098. All rights reserved.
//
// Asset Used:
// BG: http://www.clipartkid.com/images/154/clipartbest-com-FBz82W-clipart.png

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var gravityForce:CGFloat = 9.8
    
    
    override func didMove(to view: SKView) {
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        self.physicsWorld.gravity = MotionMonitor.shareMotionMonitor.gravityVectorNormalized * gravityForce
    }
}
