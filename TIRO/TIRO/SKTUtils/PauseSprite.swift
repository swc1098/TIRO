//
//  PauseSprite.swift
//  TIRO
//
//  Created by student on 11/9/16.
//  Copyright © 2016 swc1098. All rights reserved.
//

import Foundation
import SpriteKit

class PauseSprite {
    
    var node:SKShapeNode
    let pausedAlpha:CGFloat = 0.5
    
    init(){
        let rect = CGRect(x: -960, y: -540, width: 1920, height: 1080)
        node = SKShapeNode(rect: rect)
        node.fillColor = SKColor.gray
        node.alpha = pausedAlpha
        node.zPosition = 10000
        
        let PauseText:SKLabelNode = SKLabelNode(text: "Paused")
        PauseText.fontSize = 100
        PauseText.position.x = rect.midX
        PauseText.position.y = rect.midY
        PauseText.fontName = "Hobo Std"
        
        node.addChild(PauseText)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attach (scene: SKScene){
        scene.addChild(node)
    }
    
    func remove (){
        node.removeFromParent()
    }
    
    func paused(){
        node.alpha = pausedAlpha
    }
    
    func unPaused (){
        node.alpha = 0
    }
    
}
