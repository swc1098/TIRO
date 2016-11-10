//
//  PlayerNode.swift
//  TIRO
//
//  Created by student on 11/9/16.
//  Copyright © 2016 swc1098. All rights reserved.
//

import SpriteKit
class PlayerNode: SKSpriteNode, EventListenerNode {
    
    func didMoveToScene() {
        
        print("player added to scene")
        
        self.physicsBody!.categoryBitMask = PhysicsCategory.Ball
        self.physicsBody!.collisionBitMask = PhysicsCategory.Platform
            | PhysicsCategory.Edge | PhysicsCategory.Goal
        
        self.physicsBody!.contactTestBitMask = PhysicsCategory.Goal
        | PhysicsCategory.Edge
        
        self.position = CGPoint(x: 30, y: 200)
    }
}
