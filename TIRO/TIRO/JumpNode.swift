//
//  JumpNode.swift
//  TIRO
//
//  Created by student on 11/16/16.
//  Copyright © 2016 swc1098. All rights reserved.
//


import SpriteKit
class JumpNode: SKSpriteNode, EventListenerNode {
    
    func didMoveToScene() {
        
        print("jump pad added to scene")
        
        self.physicsBody!.categoryBitMask = PhysicsCategory.Jump
        self.physicsBody!.collisionBitMask = PhysicsCategory.Ball
        
        self.physicsBody!.contactTestBitMask = PhysicsCategory.Ball
        
    }
}

