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

protocol InteractiveNode {
    func interact()
}

protocol EventListenerNode {
    func didMoveToScene()
}

struct PhysicsCategory {
    static let None: UInt32 = 0
    static let Ball: UInt32 = 0b1 // 1
    static let Platform: UInt32 = 0b10 // 2
    static let Edge: UInt32 = 0b100 // 4
    static let Goal: UInt32 = 0b1000 // 8
}

class GameScene: SKScene,  SKPhysicsContactDelegate {
    
    var exitNode: ExitNode!
    var gravityForce:CGFloat = 9.8
    
    var lastUpdateTime: TimeInterval = 0
    var dt: TimeInterval = 0
    let pauseNode = PauseSprite()
    var gameIsPaused:Bool = true {
        didSet {
            gameIsPaused ? pause() : unPause()
        }
    }
    
    override func didMove(to view: SKView) {
        self.physicsWorld.gravity = CGVector.zero
        
        exitNode = childNode(withName: "ExitNode") as! ExitNode
        
        enumerateChildNodes(withName: "//*", using: { node, _ in
            if let eventListenerNode = node as? EventListenerNode {
                eventListenerNode.didMoveToScene()
            }
        })
        pauseNode.attach(scene: self)
        
        pause()
        
        run(SKAction.afterDelay(0.5, runBlock: {}))
    }
    
    
    //MARK - Pause -
    func pause() {
        run(
            SKAction.sequence([SKAction.run {
                self.pauseNode.paused()
                }, SKAction.run {
                    self.pauseNode.paused()
                    self.physicsWorld.speed = 0.0
                    self.view?.isPaused = true
                    MotionMonitor.shareMotionMonitor.stopUpdates()
                }])
        )
    }
    
    func unPause() {
        pauseNode.unPaused()
        self.view?.isPaused = false
        physicsWorld.speed = 1.0
        lastUpdateTime = 0
        MotionMonitor.shareMotionMonitor.startUpdates()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(gameIsPaused){
            gameIsPaused = false
            return
        }
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
