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
    let fillView =  UIView()
    
    
    init(_ fillPercentage: CGFloat) {
        self.fillPercentage = fillPercentage
        super.init(frame: CGRect())
        
        self.backgroundColor = UIColor.blue
        
        fillView.backgroundColor = UIColor.red
        self.addSubview(fillView)
        
        
        fillView.snp.makeConstraints {
            make in
            make.left.top.bottom.equalTo(self)
            make.width.equalTo(0)
        }
        
        self.layoutIfNeeded()
    }
    
    override init(frame: CGRect) {
        self.fillPercentage = CGFloat(1)
        super.init(frame: frame)
        
    }
    
    
    func animate(afterDelay delay: TimeInterval) {
        
        self.fillView.snp.remakeConstraints {
            make in
            
            make.left.top.bottom.equalTo(self)
            make.width.equalTo(self.snp.width).multipliedBy(fillPercentage)
        }

        UIView.animate(withDuration: 3,
                       delay: delay,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.8,
                       options: UIViewAnimationOptions.curveEaseIn,
                       animations: {() -> Void in

                        self.layoutIfNeeded()
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

