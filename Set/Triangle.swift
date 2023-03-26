//
//  Triangle.swift
//  Set
//
//  Created by Joshua Galvan on 3/22/23.
//

import SwiftUI

// Defines a triangle shape for use in displaying a SetCardSymbol.
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        let sideLength = min(rect.width, rect.height)
        let height = sqrt(sideLength * sideLength - sideLength/2 * sideLength/2)
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let vertexOne = CGPoint(
            x: center.x - sideLength/2,
            y: center.y + height / 2)
        let vertexTwo = CGPoint(x: vertexOne.x + sideLength, y: vertexOne.y)
        let vertexThree = CGPoint(x: center.x, y: center.y - height/2)
        
        var p = Path()
        p.move(to: vertexOne)
        p.addLine(to: vertexTwo)
        p.addLine(to: vertexThree)
        p.addLine(to: vertexOne)
        p.addLine(to: vertexTwo)
        return p
    }
}
