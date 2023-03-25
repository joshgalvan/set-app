//
//  EmojiSetGame.swift
//  Set
//  ViewModel
//
//  Created by Joshua Galvan on 3/20/23.
//

import Foundation

class CustomSetGame: ObservableObject {
    @Published var setGame: SetGame<SetCardSymbol>
    
    init() {
        let contents = CustomSetGame.makeSetGameCards()
        setGame = SetGame<SetCardSymbol>(cardContents: contents)
    }
    
    init(_ contents: [SetCardSymbol]) {
        setGame = SetGame<SetCardSymbol>(cardContents: contents)
    }
    
    /// Returns a randomized array of 81 "SetCardSymbol" types. You could also implement
    /// this by algorithmically producing an array of all possible (81) cards and then
    /// shuffling it, which may be more performant, but this method gave me
    /// good practice with some common protocols.
    private static func makeSetGameCards() -> [SetCardSymbol] {
        var contents: Set<SetCardSymbol> = Set()
        while contents.count < Constants.maxNumberOfCards {
            let content = SetCardSymbol.makeRandomSetCardSymbol()
            contents.insert(content)
        }
        return Array(contents)
    }
                
    var cards: [SetGame<SetCardSymbol>.Card] {
        setGame.cards
    }
    
    var canAddCards: Bool {
        setGame.canAddCards
    }
        
    private func selectedCardsAreASet(cardsToCheck: [SetGame<SetCardSymbol>.Card]) -> Bool {
        guard cardsToCheck.count == 3 else {
            return false
        }
        var numbersOfShapes: Set<NumberOfSetShapes> = Set()
        var shapes: Set<SetShape> = Set()
        var shadings: Set<SetShading> = Set()
        var colors: Set<SetColor> = Set()
        for card in cardsToCheck {
            numbersOfShapes.insert(card.content.numberOfShapes)
            shapes.insert(card.content.shape)
            shadings.insert(card.content.shading)
            colors.insert(card.content.color)
        }
        if numbersOfShapes.count == 2 || shapes.count == 2 || shadings.count == 2 || colors.count == 2 {
            return false
        } else {
            return true
        }
    }

    // - MARK: Intents
    
    func choose(_ card: SetGame<SetCardSymbol>.Card) {
        setGame.choose(card, isSetFunction: selectedCardsAreASet)
    }
    
    func addCards() {
        if setGame.canAddCards {
            setGame.addCards()
        }
    }
    
    func restart() {
        let contents = CustomSetGame.makeSetGameCards()
        setGame = SetGame<SetCardSymbol>(cardContents: contents)
    }
}

fileprivate struct Constants {
    static let maxNumberOfCards: Int = 81
}

// TODO: Remove cards when matched, take care of private _card var.
// TODO: Allow deselecting of cards when 3 are not selected
// TODO: Implement counter for how many matches you have
