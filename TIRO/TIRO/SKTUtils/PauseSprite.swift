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
    let pausedAlpha:CGFloat = 0.8
    
    init(){
        let rect = CGRect(x: -960, y: -540, width: 1920, height: 1080)
        node = SKShapeNode(rect: rect)
        node.alpha = pausedAlpha
        node.zPosition = 10000
        
        let PauseText:SKLabelNode = SKLabelNode(text: "Paused")
        PauseText.fontSize = 100
        PauseText.position.x = rect.midX
        PauseText.position.y = 400
        PauseText.fontName = "Hobo Std"
        
        node.addChild(PauseText)
        
        let playButton:SKSpriteNode = SKSpriteNode(imageNamed: "play")
        playButton.position.x = 400
        playButton.name = "play"
        playButton.position.y = rect.midY
        playButton.color = SKColor.black
        playButton.colorBlendFactor = 1.0
        playButton.blendMode = SKBlendMode.alpha
        playButton.size = CGSize(width: 300, height: 300)
        
        node.addChild(playButton)
        
        let redoButton:SKSpriteNode = SKSpriteNode(imageNamed: "redo")
        redoButton.position.x = -400
        redoButton.name = "redo"
        redoButton.position.y = rect.midY
        redoButton.color = SKColor.black
        redoButton.colorBlendFactor = 1.0
        redoButton.blendMode = SKBlendMode.alpha
        redoButton.size = CGSize(width: 300, height: 300)
        
        node.addChild(redoButton)
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
