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

protocol EventListenerNode {
    func didMoveToScene()
}



struct PhysicsCategory {
    static let None: UInt32 = 0
    static let Ball: UInt32 = 0b1 // 1
    static let Platform: UInt32 = 0b10 // 2
    static let Edge: UInt32 = 0b100 // 4
    static let Jump: UInt32 = 0b1000 // 8
    static let Hazard: UInt32 = 0b10000 // 16
    static let Goal: UInt32 = 0b100000 // 32
}

class GameScene: SKScene,  SKPhysicsContactDelegate {
    var exitNode: ExitNode!
    var playerNode: PlayerNode!
    var jumpNode: JumpNode?
    var hazardNode: HazardNode?
    var pauseButton: SKSpriteNode?
    
    var canUnPause = false
    
    static var currentlevel: Int = 0
    static var Maxlevel: Int = 5
    
    var firstUnPause = true
    
    var playable = true
    
    var gravityForce:CGFloat = 5
    var lastUpdateTime: TimeInterval = 0
    var dt: TimeInterval = 0
    let pauseNode = PauseSprite()
    var gameIsPaused:Bool = true {
        didSet {
            gameIsPaused ? pause() : unPause()
        }
    }
    
    //MARK - collision -
    override func didMove(to view: SKView) {
        firstUnPause = true
        self.physicsWorld.gravity = CGVector.zero
        //physicsBody!.categoryBitMask = PhysicsCategory.Edge
        physicsWorld.contactDelegate = self


        exitNode = childNode(withName: "exit") as! ExitNode
        playerNode = childNode(withName:"mainball") as! PlayerNode
        jumpNode = childNode(withName:"jumppad") as? JumpNode
        hazardNode = childNode(withName:"hazard") as? HazardNode
        pauseButton = childNode(withName:"pause") as! SKSpriteNode
        enumerateChildNodes(withName: "//*", using: { node, _ in
            if let eventListenerNode = node as? EventListenerNode {
                eventListenerNode.didMoveToScene()
            }
        })
        pauseNode.attach(scene: self)
        
        let music = SKAudioNode(fileNamed: "bgMusic.wav")
        addChild(music)
        //print(self.playerNode.physicsBody?.categoryBitMask)
        //print(self.exitNode.physicsBody?.categoryBitMask)
        //print(self.jumpNode?.physicsBody?.categoryBitMask)
        // print(playable)
        pause()
        

    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if !playable {
            return
        }
        let collision = contact.bodyA.categoryBitMask
            | contact.bodyB.categoryBitMask
        // simplified from physics category to see if that worked.
        if collision == 1 | 32 {
            print("SUCCESS")
            SKTAudio.sharedInstance().playSoundEffect("win.wav")
            if(GameScene.currentlevel < GameScene.Maxlevel){
                win()
            } else {
                end()
            }
            
        } else if collision == 1 | 8{
            playerNode.padJump()
            playerNode.jumpsLeft = 0
        } else if collision == 1 | 4 {
            print("FAIL")
            run(SKAction.playSoundFileNamed("fail.wav", waitForCompletion: false))
            playable = false
            lose()
        } else if collision == 1 | 16{
            print("FAIL")
            run(SKAction.playSoundFileNamed("fail.wav", waitForCompletion: false))
            playable = false
            lose()
        }
        
        if(contact.bodyA.categoryBitMask == 1 || contact.bodyB.categoryBitMask == 1){
            playerNode.restoreJumps()
        }
    }
    
    
    //MARK - Pause -
    func pause() {
        run(
            SKAction.sequence([SKAction.run {
                self.pauseNode.paused()
                }, SKAction.run {
                    self.pauseNode.paused()
                    self.physicsWorld.gravity = CGVector.zero
                    self.physicsWorld.speed = 0.0
                    self.view?.isPaused = true
                    MotionMonitor.shareMotionMonitor.stopUpdates()
                    self.canUnPause = true
                }])
        )
    }
    
    func unPause() {
        if(!canUnPause){
            return
        }
        pauseNode.unPaused()
        self.view?.isPaused = false
        physicsWorld.speed = 1.0
        lastUpdateTime = 0
        MotionMonitor.shareMotionMonitor.startUpdates()
        canUnPause = false
        if(firstUnPause){
            playerNode.physicsBody?.velocity = CGVector.zero
            playerNode.physicsBody?.angularVelocity = 0
            firstUnPause = false
        }
    }
    
    func lose() {
        perform(#selector(GameScene.loseGame), with: nil, afterDelay: 0.5)
        //loseGame()
    }
    func loseGame() {
        let scene = SKScene(fileNamed: "Lose")
        scene!.scaleMode = scaleMode
        view!.presentScene(scene)
    }
    
    func end() {
        perform(#selector(GameScene.endGame), with: nil, afterDelay: 0.5)
        //loseGame()
    }
    func endGame() {
        let scene = SKScene(fileNamed: "GameOver")
        scene!.scaleMode = scaleMode
        view!.presentScene(scene)
    }
    
    func win() {
        playable = false
        winGame()
    }
    func winGame() {
        let scene = SKScene(fileNamed: "Win")
        scene!.scaleMode = scaleMode
        view!.presentScene(scene)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(gameIsPaused){
            gameIsPaused = false
            return
        }
        
        for touch: AnyObject in touches{
            let location = touch.location(in:self)
            if pauseButton!.contains(location){
                gameIsPaused = true;
                return;
            }
        }
        playerNode.jump()
        
    }

    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        if(!gameIsPaused){
            var grav = MotionMonitor.shareMotionMonitor.gravityVectorNormalized
            
            grav.dy = -1
            
            self.physicsWorld.gravity = grav * gravityForce
            
            if(playerNode.position.y < -540){
                run(SKAction.playSoundFileNamed("fail.wav", waitForCompletion: false))
                loseGame()
            }
        
        }
    }
}
