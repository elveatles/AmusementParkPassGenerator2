//
//  UIViewExtension.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/17/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

extension CALayer {
    /**
     Add an inner shadow to this layer.
     
     - Parameter innerRadius: The inner shadow radius.
     - Parameter innerColor: The inner shadow color.
     - Parameter innerOffet: The inner shadow offset.
     - Parameter innerOpacity: The inner shadow opacity.
     - Returns: The inner shadow layer that was created.
     */
    func addInnerShadow(
        innerRadius: CGFloat = 1.0,
        innerColor: CGColor = UIColor.black.cgColor,
        innerOffset: CGSize = CGSize(width: 1, height: 1),
        innerOpacity: Float = 0.5) -> CALayer {
        // Create the inner shadow layer
        let innerShadowLayer = CALayer()
        // Make its frame the same size as this layer's bounds
        innerShadowLayer.frame = bounds
        // Create a path for the inner shadow layer that surrounds this layer's rounded bounds
        let path = UIBezierPath(roundedRect: innerShadowLayer.bounds.insetBy(dx: -20, dy: -20), cornerRadius: cornerRadius)
        let innerPath = UIBezierPath(roundedRect: innerShadowLayer.bounds, cornerRadius: cornerRadius).reversing()
        path.append(innerPath)
        innerShadowLayer.shadowPath = path.cgPath
        // Don't let the shadow go outside of this layer's rounded bounds
        innerShadowLayer.masksToBounds = true
        innerShadowLayer.cornerRadius = cornerRadius
        // Set all of the shadow properties
        innerShadowLayer.shadowRadius = innerRadius
        innerShadowLayer.shadowColor = innerColor
        innerShadowLayer.shadowOffset = innerOffset
        innerShadowLayer.shadowOpacity = innerOpacity
        // Add the inner shadow layer then return it
        addSublayer(innerShadowLayer)
        return innerShadowLayer
    }
}
