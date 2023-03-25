//
//  TestView.swift
//  Set
//
//  Created by Joshua Galvan on 3/22/23.
//

import SwiftUI

struct TestView: View {
    var game: CustomSetGame
    
    init() {
        var contents: [SetCardSymbol] = []
        contents.append(SetCardSymbol(numberOfShapes: .three, shape: .diamond, shading: .solid, color: .red))
        contents.append(SetCardSymbol(numberOfShapes: .three, shape: .diamond, shading: .clear, color: .red))
        contents.append(SetCardSymbol(numberOfShapes: .three, shape: .diamond, shading: .translucent, color: .green))
        contents.append(SetCardSymbol(numberOfShapes: .three, shape: .diamond, shading: .translucent, color: .purple))
        contents.append(SetCardSymbol(numberOfShapes: .one, shape: .diamond, shading: .translucent, color: .red))
        contents.append(SetCardSymbol(numberOfShapes: .two, shape: .diamond, shading: .translucent, color: .red))
        contents.append(SetCardSymbol(numberOfShapes: .three, shape: .triangle, shading: .translucent, color: .red))
        contents.append(SetCardSymbol(numberOfShapes: .three, shape: .oval, shading: .translucent, color: .red))
        contents.append(SetCardSymbol(numberOfShapes: .three, shape: .diamond, shading: .solid, color: .purple))
        contents.append(SetCardSymbol(numberOfShapes: .three, shape: .diamond, shading: .clear, color: .green))
        contents.append(SetCardSymbol(numberOfShapes: .two, shape: .oval, shading: .translucent, color: .red))
        contents.append(SetCardSymbol(numberOfShapes: .one, shape: .oval, shading: .translucent, color: .red))
        contents.append(SetCardSymbol(numberOfShapes: .three, shape: .triangle, shading: .translucent, color: .red))
        game = CustomSetGame(contents)
    }
    var body: some View {
        VStack {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                ForEach(game.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(4)
                }
            }
            Spacer(minLength: 0)
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
