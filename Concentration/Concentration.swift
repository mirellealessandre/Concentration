//
//  Concentration.swift
//  Concentration
//
//  Created by Mirelle Alessandre on 13/09/23.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]()
    
    private var theOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func reset() {
        for index in cards.indices {
            cards[index].isMatched = false
            cards[index].isFaceUp = false
        }
        cards.shuffle()
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at index: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = theOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                theOnlyFaceUpCard = index
            }
        }
    }
    
    init(numbersOfPairsOfCards: Int) {
        assert(numbersOfPairsOfCards > 0, "Concentration.init(\(numbersOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numbersOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}

