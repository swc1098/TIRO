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
        
        let goalBodySize = CGSize(width: 40.0, height: 30.0)
        // 97 124
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width:97, height: 124))
        physicsBody!.isDynamic = false
        
        physicsBody!.categoryBitMask = PhysicsCategory.Goal
        physicsBody!.collisionBitMask = PhysicsCategory.None
    }
}
