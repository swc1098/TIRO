//
//  ExitNode.swift
//  TIRO
//
//  Created by student on 11/9/16.
//  Copyright © 2016 swc1098. All rights reserved.
//

import SpriteKit

class ExitNode: SKSpriteNode, EventListenerNode {
    
    func didMoveToScene() {
        
        print("exit added to scene")
        
        // 97 124
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width:97, height: 124))
        self.physicsBody!.isDynamic = false
        
        self.physicsBody!.categoryBitMask = PhysicsCategory.Goal
        self.physicsBody!.collisionBitMask = PhysicsCategory.None | PhysicsCategory.Ball
        self.physicsBody!.contactTestBitMask = PhysicsCategory.Ball
        
    }
}
