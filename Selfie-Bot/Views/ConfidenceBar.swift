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

    
    init() {
        super.init(frame: CGRect())
    }

    
    override func layoutSubviews() {
        gradientLayer.frame = self.bounds
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y:0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y:0.5)
        
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.purple.cgColor]
        
        self.layer.backgroundColor = UIColor.black.cgColor
        self.layer.addSublayer(gradientLayer)
        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func animate() {

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

