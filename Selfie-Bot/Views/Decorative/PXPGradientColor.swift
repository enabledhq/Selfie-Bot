//
//  PXPGradientColor.swift
//  PXPGradientColorSampleSwift
//
//  Created by Louka Desroziers on 10/06/2014.
//  Copyright (c) 2014 PixiApps. All rights reserved.
//

import Foundation
import UIKit

class PXPGradientColor
{
    let colorSpace: PXPColorSpace
    internal let gradientRef: CGGradient
    
    private class func createGradientRefUsing(_ colors: [UIColor]!, locations: [CGFloat]?, colorSpaceRef: CGColorSpace!) -> CGGradient {
    
        var cfLocations: UnsafePointer<CGFloat>? = nil
        if locations != nil {
            cfLocations = UnsafePointer(locations!)
        }
        
        let cgColors: NSArray = colors.map {
            (color: UIColor!) -> AnyObject! in
            return color.cgColor as AnyObject!
            } as NSArray
        
        return CGGradient(colorsSpace: colorSpaceRef, colors: cgColors, locations: cfLocations)!
    }
    
    /** Initializes a PXPGradientColor object with given UIColors, locations, colorSpace. If no colorSpace provided, a deviceRGBColorSpace is used instead. If no locations provided, CGGradient automatically splits the colors by itself */
    init(colors: [UIColor], locations: [CGFloat]?, colorSpace: PXPColorSpace?) {
        self.colorSpace = (colorSpace != nil ? colorSpace! : PXPColorSpace.deviceRGBColorSpace())
        self.gradientRef = PXPGradientColor.createGradientRefUsing(colors, locations: locations, colorSpaceRef: self.colorSpace.colorSpaceRef)
    }
    
    convenience init() {
        self.init(colors: [UIColor.black, UIColor.white], locations: nil, colorSpace: PXPColorSpace.deviceGrayColorSpace())
    }
    
    convenience init(startingColor: UIColor, endingColor: UIColor) {
        self.init(colors: [startingColor, endingColor], locations: nil, colorSpace: nil)
    }
    convenience init(colors: [UIColor]) {
        self.init(colors: colors, locations: nil, colorSpace: nil)
    }
    
    private func scopedAngle(_ angle: Double) -> Double {
        return fmod(angle, 360)
    }
    
    // ##Credits goes to Cocotron
    private func retrieveStartAndEndPoints(_ startPoint: inout CGPoint, endPoint: inout CGPoint, usingAngle angle: Double, inRect rect: CGRect) {
        
        var start:CGPoint, end:CGPoint
        var tanSize: CGPoint
        
        let scopedAngle: Double = self.scopedAngle(angle)
        let positiveAngle: Double = (scopedAngle < 0 ? 360.0 - fabs(scopedAngle) : fabs(scopedAngle))
        
        start = CGPoint(x: rect.minX, y: rect.minY)
        tanSize = CGPoint(x: rect.width, y: rect.height)
        
        if positiveAngle >= 90 {
            if positiveAngle < 180 {
                start.x = rect.maxX
                tanSize.x = -rect.width
            } else if positiveAngle < 270 {
                start = CGPoint(x: rect.maxX, y: rect.maxY)
                tanSize = CGPoint(x: -rect.width, y: -rect.height)
            }
            else if positiveAngle < 360 {
                start.y = rect.maxY
                tanSize.y = -rect.height
            }
        }
        
        let radAngle: Double = positiveAngle / 180 * M_PI
        let square: Double = sqrt(Double(rect.width) * Double(rect.width) + Double(rect.height) * Double(rect.height))
        let distanceToEnd: Double = cos(atan2(Double(tanSize.y), Double(tanSize.x)) - radAngle) * square

        end = CGPoint(x: CGFloat(cos(radAngle) * distanceToEnd) + start.x, y: CGFloat(sin(radAngle) * distanceToEnd) + start.y)
        
        startPoint = start; endPoint = end
    }
    // ##End of Credits

    func draw(inRect rect: CGRect, angle: Double) {
        self.draw(inBezierPath: UIBezierPath(rect: rect), angle: angle)
    }
    
    func draw(inBezierPath bezierPath: UIBezierPath, angle: Double) {
        let ctx: CGContext = UIGraphicsGetCurrentContext()!
        ctx.saveGState()
        ctx.addPath(bezierPath.cgPath)
        ctx.clip()
        
        var startPoint: CGPoint = CGPoint.zero
        var endPoint: CGPoint = CGPoint.zero
        self.retrieveStartAndEndPoints(&startPoint, endPoint: &endPoint, usingAngle: angle, inRect: bezierPath.bounds)
        
        ctx.drawLinearGradient(self.gradientRef, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: 0))
        ctx.restoreGState()
    }
    
}
