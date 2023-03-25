//
//  SetGame.swift
//  Set
//  Model
//
//  Created by Joshua Galvan on 3/20/23.
//

import Foundation

struct SetGame<CardContent: Equatable> where CardContent: Hashable {
    
    private var _cards: [Card]
    private(set) var cards: [Card]
    private(set) var selectedCards: [Card]
    private var thereWasAMatch: Bool = false
    
    var canAddCards: Bool {
        if cards.count == 81 {
            return false
        } else {
            return true
        }
    }
    
    init(cardContents: [CardContent]) {
        selectedCards = []
        _cards = []
        cards = []
        for i in 0..<cardContents.count {
            let content = cardContents[i]
            _cards.append(Card(content: content))
        }
        for i in 0..<12 {
            cards.append(_cards[i])
        }
    }
    
    // TODO: Implement fully
    mutating func choose(_ card: Card, isSetFunction: ([Card]) -> Bool) {
        let selectedIndex = cards.firstIndex(where: { $0.id == card.id })
        if let selectedIndex, !cards[selectedIndex].isMatched {
            var cardOneIndex: Int? = 0
            var cardTwoIndex: Int? = 0
            var cardThreeIndex: Int? = 0
            if selectedCards.count < 3, !cards[selectedIndex].isSelected {
                cards[selectedIndex].isSelected = true
                selectedCards.append(cards[selectedIndex])
                if isSetFunction(selectedCards) {
                    cardOneIndex = cards.firstIndex(where: { $0.id == selectedCards[0].id })
                    cardTwoIndex = cards.firstIndex(where: { $0.id == selectedCards[1].id })
                    cardThreeIndex = cards.firstIndex(where: { $0.id == selectedCards[2].id })
                    cards[cardOneIndex!].isMatched = true
                    cards[cardTwoIndex!].isMatched = true
                    cards[cardThreeIndex!].isMatched = true
                    thereWasAMatch = true
                }
            } else if selectedCards.count == 3 {
                if thereWasAMatch {
                    print("There was a match")
                    thereWasAMatch = false
                }
                for i in 0..<cards.count {
                    cards[i].isSelected = false
                }
                cards[selectedIndex].isSelected = true
                selectedCards = [cards[selectedIndex]]
            }
        }
    }

    mutating func addCards() {
        print("_cards")
        let _cardsSet = Set(_cards)
        print(_cardsSet.count)
        print(_cards.count)
        for c in _cards {
            print(c.content)
        }
        print("cards")
        for c in cards {
            print(c.content)
        }
        for _ in 0...2 {
            cards.append(_cards[cards.count])
        }
    }
    
    struct Card: Identifiable, Hashable {
        var isMatched: Bool = false
        var isSelected: Bool = false
        let id = UUID()
        var content: CardContent
    }
}

// (three, diamond, translucent, red) is showing up as two diamonds
// (three, diamond, clear, red) is showing up as two diamonds
// (three, diamond, solid, green) is showing up as two diamonds
// (three, diamond, translucent, purple) is showing up as two diamond
// (three, diamond, solid, red) is showing up as two diamond
// Obs: There are no 3 diamond cards on the board. Issue with displaying 3 diamonds.
