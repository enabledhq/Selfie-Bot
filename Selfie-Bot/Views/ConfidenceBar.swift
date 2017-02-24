//
//  ConfidenceBar.swift
//  Selfie-Bot
//
//  Created by John Smith on 23/2/17.
//  Copyright © 2017 Enabled. All rights reserved.
//

import Foundation
import UIKit

class ConfidenceBar: UIView, CAAnimationDelegate {
    
    let gradientLayer = CAGradientLayer()
    let maskLayer = CALayer()
    let fillPercentage: CGFloat
    
    
    init(_ fillPercentage: CGFloat) {
        self.fillPercentage = fillPercentage
        super.init(frame: CGRect())
    }
    
    
    
    override func layoutSubviews() {
        gradientLayer.frame = self.bounds
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y:0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y:0.5)
        
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.red.cgColor]
        
        self.layer.backgroundColor = UIColor.gray.withAlphaComponent(0.2).cgColor
        self.layer.addSublayer(gradientLayer)
        self.layer.cornerRadius = layer.bounds.height / 2
        self.layer.masksToBounds = true
        
        
        let mask = CALayer()
        mask.backgroundColor = UIColor.black.cgColor
        
        
        let bounds = self.gradientLayer.bounds
        mask.frame = CGRect(x: bounds.minX,
                            y: bounds.minY,
                            width: bounds.width,
                            height: bounds.height)
        
        self.gradientLayer.mask = mask
        
        UIView.animate(withDuration: 1,
                       delay: 1,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.8,
                       options: UIViewAnimationOptions.curveEaseIn,
                       animations: {() -> Void in
                        
                        //FIXME: This is not animating correctly
                        mask.frame = CGRect(x: bounds.minX,
                                            y: bounds.minY,
                                            width: bounds.width.multiplied(by: self.fillPercentage),
                                            height: bounds.height)
                        
        })
        
        
    }
    
    override init(frame: CGRect) {
        self.fillPercentage = CGFloat(1)
        super.init(frame: frame)
    }
    
    func animate() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

