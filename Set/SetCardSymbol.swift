//
//  SetCardSymbol.swift
//  Set
//
//  Created by Joshua Galvan on 3/22/23.
//

import Foundation

struct SetCardSymbol: Equatable, Hashable, CustomStringConvertible {
    let numberOfShapes: NumberOfSetShapes
    let shape: SetShape
    let shading: SetShading
    let color: SetColor
    
    static func ==(left: Self, right: Self) -> Bool {
        if left.numberOfShapes == right.numberOfShapes &&
            left.shape == right.shape &&
            left.shading == right.shading &&
            left.color == right.color {
            return true
        } else {
            return false
        }
    }
    
    static func makeRandomSetCardSymbol() -> SetCardSymbol {
        SetCardSymbol(numberOfShapes: .random(), shape: .random(), shading: .random(), color: .random())
    }
    
    var description: String {
        var description = "("
        switch numberOfShapes {
        case .one: description += "one, "
        case .two: description += "two, "
        case .three: description += "three, "
        }
        switch shape {
        case .diamond: description += "diamond, "
        case .triangle: description += "triangle, "
        case .oval: description += "oval, "
        }
        switch shading {
        case .solid: description += "solid, "
        case .translucent: description += "translucent, "
        case .clear: description += "clear, "
        }
        switch color {
        case .red: description += "red)"
        case .green: description += "green)"
        case .purple: description += "purple)"
        }
        return description
    }
}

enum NumberOfSetShapes: CaseIterable {
    case one, two, three
}

enum SetShape: CaseIterable {
    case diamond, triangle, oval
}

enum SetShading: CaseIterable {
    case solid, translucent, clear
}

enum SetColor: CaseIterable {
    case red, green, purple
}

extension CaseIterable {
    static func random() -> Self {
        var g = SystemRandomNumberGenerator()
        return Self.allCases.randomElement(using: &g)!
    }
}
