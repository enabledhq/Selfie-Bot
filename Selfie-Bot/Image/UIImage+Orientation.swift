//
//  UIImage+Orientation.swift
//  Selfie-Bot
//
//  Created by Simeon on 22/2/17.
//  Copyright © 2017 Enabled. All rights reserved.
//

import UIKit

extension UIImage {
    
    func normalizeOrientation() -> UIImage {
        
        if imageOrientation == .up {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image ?? self        
    }
}
