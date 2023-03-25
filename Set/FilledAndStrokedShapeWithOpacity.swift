//
//  FilledAndStrokedShapeWithOpacity.swift
//  Set
//
//  Created by Joshua Galvan on 3/23/23.
//

import SwiftUI

struct FilledAndStrokedShapeWithOpacity<Content>: View where Content: Shape {
    let opacity: Double
    let lineWidth: CGFloat
    let content: () -> Content
    
    init(opacity: Double, lineWidth: CGFloat, @ViewBuilder content: @escaping () -> Content) {
        self.opacity = opacity
        self.lineWidth = lineWidth
        self.content = content
    }
    
    var body: some View {
        ZStack {
            content().fill().opacity(opacity)
            content().stroke(lineWidth: lineWidth)
        }
    }
}

struct FilledAndStrokedShapeWithOpacity_Previews: PreviewProvider {
    static var previews: some View {
        FilledAndStrokedShapeWithOpacity(opacity: 0.5, lineWidth: 10) {
            Diamond()
        }
    }
}
