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
    
    init(options: [String : Any]? = nil) {
        // Load Selfie Bot scene
        if let botScene = SCNScene(named: "SelfieBot.scn"),
            let botNode = botScene.rootNode.childNode(withName: "SelfieBot", recursively: true),
            let teethNode = botScene.rootNode.childNode(withName: "Lower_Teeth", recursively: true) {
            
            botNode.position = SCNVector3(x: 0, y: 2.4, z: 0)
            
            botScene.rootNode.addChildNode(lookingAt)
            lookingAt.position = SCNVector3(x: 0, y: 2.4, z: -5)
            
            //botNode.rotation = SCNVector4(x: 0.1, y: 0, z: 0, w: 1.0)
            //botNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 2, y: 0, z: 0, duration: 1.0)))
            
            selfieBot = botNode
            lowerTeeth = teethNode
            
            selfieBot.constraints = [SCNLookAtConstraint(target: lookingAt)]
        
            super.init(frame: .zero, options: options)
            
            scene = botScene
        } else {
            fatalError("Failed to load SelfieBot.scn")
        }
        
        backgroundColor = .clear
        antialiasingMode = .multisampling4X
        isUserInteractionEnabled = false
    }
    
    func lookAt(point: CGPoint, duration: TimeInterval = 0.3) {
        
        let world = unprojectPoint(SCNVector3(x: Float(point.x), y: Float(point.y), z: 0.98))        
        lookingAt.runAction(SCNAction.move(to: world, duration: duration))
        
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
