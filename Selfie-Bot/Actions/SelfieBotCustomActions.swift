//
//  SelfieBotCustomActions.swift
//  Selfie-Bot
//
//  Created by Simeon on 19/2/17.
//  Copyright © 2017 Enabled. All rights reserved.
//

import UIKit
import SceneKit

func chatter(node: SCNNode, elapsedTime: CGFloat) {
    
    let minMove: CGFloat = 0.036
    let maxMove: CGFloat = -0.07
    
    let movementRange = (minMove - maxMove)/2.0
    let existingPos = node.position
    
    let y = sin(elapsedTime * 18.0 + 0.25) * movementRange - minMove/2.0
    
    node.position = SCNVector3(x: existingPos.x, y: Float(y), z: existingPos.z)
    
}

func speakWordsAction(wordCount count: Int) -> SCNAction {
    
    let chatterAction = SCNAction.customAction(duration: 0.348, action: chatter)
    
    return SCNAction.repeat(chatterAction, count: count)
    
}
