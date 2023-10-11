//
//  Card.swift
//  Concentration
//
//  Created by Mirelle Alessandre on 13/09/23.
//

import Foundation

struct Card: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int

    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
