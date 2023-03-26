//
//  Diamond.swift
//  Set
//
//  Created by Joshua Galvan on 3/22/23.
//

import SwiftUI

// Defines a diamond shape for use in displaying a SetCardSymbol.
struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let width = rect.width
        let height = rect.height
        let left = CGPoint(x: center.x - width/2, y: center.y)
        let top = CGPoint(x: center.x, y: center.y - min(height/2 - 1, width/4))
        let right = CGPoint(x: center.x + width/2, y: center.y)
        let bottom = CGPoint(x: center.x, y: center.y + min(height/2 - 1, width/4))
        
        var p = Path()
        p.move(to: left)
        p.addLine(to: top)
        p.addLine(to: right)
        p.addLine(to: bottom)
        p.addLine(to: left)
        p.addLine(to: top)
        return p
    }
}
