//
//  HazardNode.swift
//  TIRO
//
//  Created by student on 11/16/16.
//  Copyright © 2016 swc1098. All rights reserved.
//

import SpriteKit
class HazardNode: SKSpriteNode, EventListenerNode {
    
    let movementForce: CGVector = CGVector(dx: 0, dy: 120)
    var canJump = true
    func didMoveToScene() {
        print("stage hazard added to scene")
        
        self.physicsBody!.categoryBitMask = PhysicsCategory.Hazard
        self.physicsBody!.collisionBitMask =  PhysicsCategory.Platform
        
        self.physicsBody!.contactTestBitMask = PhysicsCategory.Ball | PhysicsCategory.Platform
        
        self.physicsBody?.applyImpulse(self.movementForce)
        
    }
}
