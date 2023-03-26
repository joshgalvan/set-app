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
    // _indexOfNextCardToShow is needed because elements are removed and reordered from
    // 'cards' and we still need to track what cards to add to 'cards' from '_cards' so
    // we can exhaust them.
    private var _indexOfNextCardToShow: Int
    private(set) var cards: [Card]
    private(set) var selectedCards: [Card]
    private(set) var numberOfMatches: Int = 0
    private var thereWasAMatch: Bool = false
    
    var canAddCards: Bool {
        if _indexOfNextCardToShow == 81 {
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
        _indexOfNextCardToShow = 12
    }
    
    mutating func choose(_ card: Card, isSetFunction: ([Card]) -> Bool) {
        let selectedIndex = cards.firstIndex(where: { $0.id == card.id })
        if let selectedIndex, !cards[selectedIndex].isMatched {
            // This is the amount of selectedCards right before the tap gesture.
            if selectedCards.count < 3 {
                if cards[selectedIndex].isSelected {
                    cards[selectedIndex].isSelected = false
                    selectedCards.removeAll(where: { $0.id == cards[selectedIndex].id })
                } else {
                    cards[selectedIndex].isSelected = true
                    selectedCards.append(cards[selectedIndex])
                    
                    let isASet = isSetFunction(selectedCards)
                    if isASet {
                        let indexes = getSelectedCardsIndexes()
                        for index in indexes {
                            cards[index!].isMatched = true
                        }
                        thereWasAMatch = true
                        numberOfMatches += 1
                    } else if !isASet, selectedCards.count == 3 {
                        // selectedCards.count would be 3 here because we just appended a card, if able to.
                        let indexes = getSelectedCardsIndexes()
                        for index in indexes {
                            cards[index!].matchFailed = true
                        }
                    }
                }
            } else if selectedCards.count == 3 {
                for i in 0..<cards.count {
                    cards[i].isSelected = false
                    cards[i].matchFailed = false
                }
                cards[selectedIndex].isSelected = true
                selectedCards = [cards[selectedIndex]]
                if thereWasAMatch {
                    if canAddCards {
                        for i in 0..<cards.count {
                            if cards[i].isMatched {
                                cards[i] = _cards[_indexOfNextCardToShow]
                                _indexOfNextCardToShow += 1
                            }
                        }
                    } else {
                        cards.removeAll(where: { $0.isMatched == true })
                    }
                    thereWasAMatch = false
                }
            }
        }
        
        func getSelectedCardsIndexes() -> [Int?] {
            var indexes: [Int?] = []
            for i in 0..<selectedCards.count {
                indexes.append(cards.firstIndex(where: { $0.id == selectedCards[i].id }))
            }
            return indexes
            
        }
    }

    mutating func addCards() {
        for _ in 0...2 {
            cards.append(_cards[_indexOfNextCardToShow])
            _indexOfNextCardToShow += 1
        }
    }
    
    struct Card: Identifiable, Hashable {
        var isMatched: Bool = false
        var matchFailed: Bool = false
        var isSelected: Bool = false
        let id = UUID()
        var content: CardContent
    }
}
