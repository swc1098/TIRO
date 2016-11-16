//
//  PlayerNode.swift
//  TIRO
//
//  Created by student on 11/9/16.
//  Copyright © 2016 swc1098. All rights reserved.
//

import SpriteKit
class PlayerNode: SKSpriteNode, EventListenerNode {
    
    let jumpForce: CGVector = CGVector(dx: 0, dy: 150)
    let padForce: CGVector = CGVector(dx:0, dy: 300)
    var jumpsLeft = 0
    var maxJumps = 1
    
    func didMoveToScene() {
        
        print("player added to scene")
        
        self.physicsBody!.categoryBitMask = PhysicsCategory.Ball
        self.physicsBody!.collisionBitMask = PhysicsCategory.Platform
            | PhysicsCategory.Edge | PhysicsCategory.Goal
        
        self.physicsBody!.contactTestBitMask = PhysicsCategory.Goal
        | PhysicsCategory.Edge | PhysicsCategory.Platform
        
    }
    
    func restoreJumps(){
        jumpsLeft = maxJumps
    }
    
    func jump(){
        if(jumpsLeft > 0){
            jumpsLeft -= 1;
            self.physicsBody?.applyImpulse(self.jumpForce)
        }
    }
    
    func padJump(){
        self.physicsBody?.applyImpulse(self.padForce)
    }
}
