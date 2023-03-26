//
//  ContentView.swift
//  Set
//  View
//
//  Created by Joshua Galvan on 3/20/23.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: CustomSetGame
    
    var body: some View {
        VStack {
            AdaptableToScrollVGrid(items: game.cards, aspectRatio: Constant.aspectRatio) { card in
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {
                        game.choose(card)
                    }
            }
            .cornerRadius(Constant.cornerRadius)
            .padding(.horizontal, 4)
            
            CustomNavBar {
                Button {
                    game.restart()
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
            } center: {
                Button {
                    game.addCards()
                } label: {
                    if game.canAddCards == true {
                        Text("3 More Cards")
                    } else {
                        Text("No More Cards")
                            .foregroundColor(.red)
                    }
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
            } right: {
                // I know this is not an ideal place to put this info (in the navigation
                // bar), but the sizing of the VGrid is great, and adding a header at the
                // top would mess it up. Plus, this is a simple app for the purpose of
                // practicing.
                Text("\(game.numberOfMatches)")
                    .foregroundColor(.yellow)
                    .font(.largeTitle)
            }
            .padding([.leading, .trailing])
            .padding(.top, 8)
        }
    }
}

struct CardView: View {
    let card: SetGame<SetCardSymbol>.Card

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let cardShape = RoundedRectangle(cornerRadius: Constant.cornerRadius)
                cardShape.fill().foregroundColor(Color("cardFillColor"))
                if card.matchFailed {
                    cardShape.strokeBorder(lineWidth: Constant.cardLineWidth)
                        .foregroundColor(.red)
                } else if card.isMatched {
                    cardShape.strokeBorder(lineWidth: Constant.cardLineWidth)
                        .foregroundColor(.green)
                } else if card.isSelected {
                    cardShape.strokeBorder(lineWidth: Constant.cardLineWidth)
                        .foregroundColor(.blue)
                } else {
                    cardShape.strokeBorder(lineWidth: Constant.cardLineWidth)
                        .foregroundColor(Color("cardBorderColor"))
                }
                SetCardSymbolView(content: card.content)
                    .padding()
            }
        }
    }
}

fileprivate struct Constant {
    static let aspectRatio: CGFloat = 2/3
    static let cornerRadius: CGFloat = 20
    static let cardLineWidth: CGFloat = 3.0
    static let fontScale: CGFloat = 0.7
    static let opacity: CGFloat = 0.5
    static let maxNumberOfCardsWithNoScrollView: Int = 42
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = CustomSetGame()
        SetGameView(game: game)
            .preferredColorScheme(.light)
        SetGameView(game: game)
            .preferredColorScheme(.dark)
    }
}
