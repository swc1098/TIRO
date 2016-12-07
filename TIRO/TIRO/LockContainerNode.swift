//
//  LockContainerNode.swift
//  TIRO
//
//  Created by Daniel law on 12/7/16.
//  Copyright © 2016 swc1098. All rights reserved.
//

import SpriteKit
class LockContainerNode: SKNode, EventListenerNode {
    
    func didMoveToScene() {
        
        print("locks added to scene")
        
        //self.children
        
    }
    
    func destroy() {
        print("boop")
        
        //customs delays require adding the feild to the locks userdata object in the sks file.
        var delay: TimeInterval? = self.userData?["delay"] as? TimeInterval
        
        if(delay == nil){ delay = 0.25 }
        
        let action = SKAction.afterDelay(delay!, runBlock: {
                self.children.last?.removeFromParent()
            })
        
        run(SKAction.repeat(action, count: self.children.count))
    }
}

class KeyNode: SKSpriteNode, EventListenerNode {
    
    func didMoveToScene() {
        
        print("key added to scene")
        
        self.physicsBody!.categoryBitMask = PhysicsCategory.Key
         self.physicsBody!.contactTestBitMask = PhysicsCategory.Ball
        
    }
}


