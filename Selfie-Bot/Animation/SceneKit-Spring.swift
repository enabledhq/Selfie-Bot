//
//  SceneKit-Spring.swift
//  Selfie-Bot
//
//  Created by Simeon on 21/2/17.
//  Copyright © 2017 Enabled. All rights reserved.
//

import SceneKit


//MARK: - Spring Movement

extension SCNNode {
    
    public func moveBy(x deltaX: Float, y deltaY: Float, z deltaZ: Float, duration: TimeInterval, usingSpringWithDamping damping: CGFloat, initialSpringVelocity velocity: CGFloat) {

        move(by: SCNVector3(x: deltaX, y: deltaY, z: deltaZ), duration: duration, usingSpringWithDamping: damping, initialSpringVelocity: velocity)
    }
    
    public func move(by delta: SCNVector3, duration: TimeInterval, usingSpringWithDamping damping: CGFloat, initialSpringVelocity velocity: CGFloat) {
        
        move(to: SCNVector3(x: position.x + delta.x, y: position.y + delta.y, z: position.z + delta.z), duration: duration, usingSpringWithDamping: damping, initialSpringVelocity: velocity)
    }
    
    public func move(to location: SCNVector3, duration: TimeInterval, usingSpringWithDamping damping: CGFloat, initialSpringVelocity velocity: CGFloat) {
        
        let animation = CASpringAnimation(keyPath: "position")
        
        let toVal = NSValue(scnVector3: location)
        
        animation.toValue = toVal
        animation.duration = duration
        animation.damping = damping
        animation.stiffness = 0.5
        animation.mass = 10.0
        animation.initialVelocity = velocity
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        
        addAnimation(animation, forKey: nil)
    }
}

//MARK: - Spring Rotation

