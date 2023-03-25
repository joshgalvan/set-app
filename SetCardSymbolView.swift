//
//  SetCardSymbolView.swift
//  Set
//
//  Created by Joshua Galvan on 3/23/23.
//

import SwiftUI

struct SetCardSymbolView: View {
    let content: SetCardSymbol
    
    // Definitely a better way to do this, as is it is pretty messy.
    var body: some View {
        VStack {
            switch content.shape {
            case .oval:
                switch content.numberOfShapes {
                case .one:
                    FilledAndStrokedShapeWithOpacity(opacity: content.shading.toDouble(), lineWidth: Constant.lineWidth) {
                        Capsule()
                    }
                    .aspectRatio(2, contentMode: .fit)
                case .two:
                    FilledAndStrokedShapeWithOpacity(opacity: content.shading.toDouble(), lineWidth: Constant.lineWidth) {
                        Capsule()
                    }
                    .aspectRatio(2, contentMode: .fit)
                    FilledAndStrokedShapeWithOpacity(opacity: content.shading.toDouble(), lineWidth: Constant.lineWidth) {
                        Capsule()
                    }
                    .aspectRatio(2, contentMode: .fit)
                case .three:
                    FilledAndStrokedShapeWithOpacity(opacity: content.shading.toDouble(), lineWidth: Constant.lineWidth) {
                        Capsule()
                    }
                    .aspectRatio(2, contentMode: .fit)
                    FilledAndStrokedShapeWithOpacity(opacity: content.shading.toDouble(), lineWidth: Constant.lineWidth) {
                        Capsule()
                    }
                    .aspectRatio(2, contentMode: .fit)
                    FilledAndStrokedShapeWithOpacity(opacity: content.shading.toDouble(), lineWidth: Constant.lineWidth) {
                        Capsule()
                    }
                    .aspectRatio(2, contentMode: .fit)
                }
            case .triangle:
                switch content.numberOfShapes {
                case .one:
                    FilledAndStrokedShapeWithOpacity(opacity: content.shading.toDouble(), lineWidth: Constant.lineWidth) {
                        Triangle()
                    }
                case .two:
                    FilledAndStrokedShapeWithOpacity(opacity: content.shading.toDouble(), lineWidth: Constant.lineWidth) {
                        Triangle()
                    }
                    FilledAndStrokedShapeWithOpacity(opacity: content.shading.toDouble(), lineWidth: Constant.lineWidth) {
                        Triangle()
                    }
                case .three:
                    FilledAndStrokedShapeWithOpacity(opacity: content.shading.toDouble(), lineWidth: Constant.lineWidth) {
                        Triangle()
                    }
                    FilledAndStrokedShapeWithOpacity(opacity: content.shading.toDouble(), lineWidth: Constant.lineWidth) {
                        Triangle()
                    }
                    FilledAndStrokedShapeWithOpacity(opacity: content.shading.toDouble(), lineWidth: Constant.lineWidth) {
                        Triangle()
                    }
                }
            case .diamond:
                switch content.numberOfShapes {
                case .one:
                    FilledAndStrokedShapeWithOpacity(opacity: content.shading.toDouble(), lineWidth: Constant.lineWidth) {
                        Diamond()
                    }
                case .two:
                    FilledAndStrokedShapeWithOpacity(opacity: content.shading.toDouble(), lineWidth: Constant.lineWidth) {
                        Diamond()
                    }
                    FilledAndStrokedShapeWithOpacity(opacity: content.shading.toDouble(), lineWidth: Constant.lineWidth) {
                        Diamond()
                    }
                case .three:
                    FilledAndStrokedShapeWithOpacity(opacity: content.shading.toDouble(), lineWidth: Constant.lineWidth) {
                        Diamond()
                    }
                    FilledAndStrokedShapeWithOpacity(opacity: content.shading.toDouble(), lineWidth: Constant.lineWidth) {
                        Diamond()
                    }
                    FilledAndStrokedShapeWithOpacity(opacity: content.shading.toDouble(), lineWidth: Constant.lineWidth) {
                        Diamond()
                    }
                }
            }
        }
        .foregroundColor(content.color.toSwiftUIColor())
    }
}

fileprivate struct Constant {
    static let lineWidth: CGFloat = 2.0
}

extension SetColor {
    func toSwiftUIColor() -> Color {
        switch self {
        case .red: return Color.red
        case .green: return Color.green
        case .purple: return Color.purple
        }
    }
}

extension SetShading {
    func toDouble() -> Double {
        switch self {
        case .solid: return 1.0
        case .translucent: return 0.3
        case .clear: return 0.0
        }
    }
}