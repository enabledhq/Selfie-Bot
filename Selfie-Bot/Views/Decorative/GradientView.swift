//
//  GradientView.swift
//  BrewArt
//
//  Created by Simeon on 25/02/2015.
//  Copyright (c) 2015 Enabled. All rights reserved.
//

import UIKit

class GradientView: UIView
{

    init(gradient: PXPGradientColor, frame: CGRect)
    {
        self.gradient = gradient
        
        super.init(frame: frame)
        isUserInteractionEnabled = false
        backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    var gradient: PXPGradientColor? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var angle: Double = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect)
    {
        if let gradient = gradient
        {
            gradient.draw(inRect: rect, angle: angle)
        }
    }

}
