//
//  SelfieBotView.swift
//  Selfie-Bot
//
//  Created by Simeon on 17/2/17.
//  Copyright © 2017 Enabled. All rights reserved.
//

import UIKit
import SceneKit

class SelfieBotView: SCNView {
    
    private let selfieBot: SCNNode
    private let lowerTeeth: SCNNode
    
    private let lookingAt = SCNNode()
    private let fieldNode = SCNNode()
    
    init(options: [String : Any]? = nil) {
        // Load Selfie Bot scene
        if let botScene = SCNScene(named: "SelfieBot.scn"),
            let botNode = botScene.rootNode.childNode(withName: "SelfieBotRoot", recursively: true),
            let teethNode = botScene.rootNode.childNode(withName: "Lower_Teeth", recursively: true) {
            
            botNode.position = SCNVector3(x: 0, y: 2.4, z: 0)
            
            botScene.rootNode.addChildNode(lookingAt)
            botScene.rootNode.addChildNode(fieldNode)
            
            lookingAt.position = SCNVector3(x: 0, y: 2.4, z: -1)
            
            let body = SCNPhysicsBody(type: .dynamic, shape: SCNPhysicsShape(geometry: SCNBox(width: 0.2, height: 0.2, length: 0.2, chamferRadius: 0.0)))
            body.damping = 0.9
            body.allowsResting = false
            lookingAt.physicsBody = body

            selfieBot = botNode
            lowerTeeth = teethNode
            
            selfieBot.constraints = [SCNLookAtConstraint(target: lookingAt)]
        
            super.init(frame: .zero, options: options)
            
            scene = botScene
        } else {
            fatalError("Failed to load SelfieBot.scn")
        }
        
        backgroundColor = .clear
        antialiasingMode = .multisampling2X
        isUserInteractionEnabled = false
        
        scene?.physicsWorld.gravity = SCNVector3Zero
    }
    
    func lookAt(point: CGPoint, duration: TimeInterval = 0.3) {
        
        let world = unprojectPoint(SCNVector3(x: Float(point.x), y: Float(point.y), z: 0.985))
        
        fieldNode.physicsField = SCNPhysicsField.spring()
        fieldNode.position = world
        
        //Close your mouth, Selfie-Bot
        let sequence = [SCNAction.wait(duration: duration), SCNAction.move(to: SCNVector3(x: 0, y: 0.016, z: 0), duration: duration/2.0)]
        lowerTeeth.runAction(SCNAction.sequence(sequence))
    }
    
    func speakWords(wordCount count: Int) {
        
        lowerTeeth.runAction(speakWordsAction(wordCount: count))
    }    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
