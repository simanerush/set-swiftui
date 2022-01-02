//
//  Game.swift
//  Game
//
//  Created by Serafima Nerush on 12/28/21.
//

import Foundation
import SwiftUI

struct Game {
    
    private(set) var cards: Array<Card>
    
    var addMoreCards: Bool
    
    private(set) var numberOfCardsToBeAdded: Int
    
    private var countOfMatches: Int
    
    init() {
        cards = []
        
        addMoreCards = false
        
        countOfMatches = 0
        
        numberOfCardsToBeAdded = 12
        
        indicesOfChosenCards = [Int]()
        
        for i in 1...81 {
            cards.append(Card(color: Colors.red, shape: Shapes.diamond, pattern: Patterns.plain, count: 1, id: i))
        }
        
        
        var countTilda = 0
        var countRect = 0
        var countDiamond = 0
        
        for i in cards.indices {
            if countDiamond >= 27 {
                cards[i].shape = Shapes.rectangle
            }
            
            if countDiamond >= 9 && cards[i].shape == Shapes.diamond {
                cards[i].color = Colors.green
            }
            
            if countDiamond >= 18 && cards[i].shape == Shapes.diamond {
                cards[i].color = Colors.purple
            }
            
            if countRect >= 27 {
                cards[i].shape = Shapes.tilda
            }
            
            if countRect >= 9 && cards[i].shape == Shapes.rectangle {
                cards[i].color = Colors.green
            }
            
            if countRect >= 18 && cards[i].shape == Shapes.rectangle {
                cards[i].color = Colors.purple
            }
            
            if countTilda >= 9 {
                cards[i].color = Colors.green
            }
            
            if countTilda >= 18 {
                cards[i].color = Colors.purple
            }
            
            if cards[i].shape == Shapes.tilda {
                countTilda += 1
            }
            if cards[i].shape == Shapes.rectangle {
                countRect += 1
            }
            if cards[i].shape == Shapes.diamond {
                countDiamond += 1
            }
            
        }
        
        // я гений
        for i in cards.indices {
            if i % 3 == 0 {
                cards[i].count = 1
            }
            if i % 3 == 1 {
                cards[i].count = 2
            }
            if i % 3 == 2 {
                cards[i].count = 3
            }
        }
        
        var i = 0
        while i < cards.count - 8 {
            cards[i].pattern = Patterns.plain
            cards[i + 1].pattern = Patterns.plain
            cards[i + 2].pattern = Patterns.plain
            cards[i + 3].pattern = Patterns.stripes
            cards[i + 4].pattern = Patterns.stripes
            cards[i + 5].pattern = Patterns.stripes
            cards[i + 6].pattern = Patterns.filled
            cards[i + 7].pattern = Patterns.filled
            cards[i + 8].pattern = Patterns.filled
            
            i += 9
        }
        
        cards.shuffle()
    }
    
    // Three chosen cards are a set if:
    // 1. They have the same count or three different counts.
    // 2. They have the same shape or have three different shapes.
    // 3. They have the same pattern or three different patterns.
    // 4. They all have the same color or three different colors.
    
    private var indicesOfChosenCards: [Int]
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }), !cards[chosenIndex].isFaceUp {
            
            if indicesOfChosenCards.count == 3 {
                if cards[indicesOfChosenCards[0]].shape == cards[indicesOfChosenCards[1]].shape && cards[indicesOfChosenCards[2]].shape == cards[indicesOfChosenCards[1]].shape || cards[indicesOfChosenCards[0]].shape != cards[indicesOfChosenCards[1]].shape && cards[indicesOfChosenCards[2]].shape != cards[indicesOfChosenCards[1]].shape && cards[indicesOfChosenCards[0]].count == cards[indicesOfChosenCards[1]].count && cards[indicesOfChosenCards[2]].count == cards[indicesOfChosenCards[1]].count || cards[indicesOfChosenCards[0]].count != cards[indicesOfChosenCards[1]].count && cards[indicesOfChosenCards[2]].count != cards[indicesOfChosenCards[1]].count && cards[indicesOfChosenCards[0]].pattern == cards[indicesOfChosenCards[1]].pattern && cards[indicesOfChosenCards[2]].pattern == cards[indicesOfChosenCards[1]].pattern || cards[indicesOfChosenCards[0]].pattern != cards[indicesOfChosenCards[1]].pattern && cards[indicesOfChosenCards[2]].pattern != cards[indicesOfChosenCards[1]].pattern && cards[indicesOfChosenCards[0]].color == cards[indicesOfChosenCards[1]].color && cards[indicesOfChosenCards[2]].color == cards[indicesOfChosenCards[1]].color || cards[indicesOfChosenCards[0]].color != cards[indicesOfChosenCards[1]].color && cards[indicesOfChosenCards[2]].color != cards[indicesOfChosenCards[1]].color {
                    
                    cards[indicesOfChosenCards[2]].isMatched = true
                    cards[indicesOfChosenCards[0]].isMatched = true
                    cards[indicesOfChosenCards[1]].isMatched = true
                    
                    countOfMatches += 1
                    indicesOfChosenCards = []
                } else {
                    for index in indicesOfChosenCards {
                        cards[index].isFaceUp = false
                        indicesOfChosenCards = []
                    }
                }
            }
            
            if indicesOfChosenCards.count < 3 {
                indicesOfChosenCards.append(chosenIndex)
            }
            cards[chosenIndex].isFaceUp = true
            
            if countOfMatches >= 3 {
                addMoreCards = true
                if numberOfCardsToBeAdded >= 72 {
                    numberOfCardsToBeAdded = 80
                } else {
                    numberOfCardsToBeAdded += 12
                }
                countOfMatches = 0
            }
        }
    }
    
    struct Card: Identifiable {
        var color: Colors
        var shape: Shapes
        var pattern: Patterns
        var count: Int
        var isFaceUp = false
        var isMatched = false
        let id: Int
    }
    
    enum Colors {
        case red
        case green
        case purple
    }
    
    enum Shapes {
        case diamond
        case rectangle
        case tilda
    }
    
    enum Patterns {
        case plain
        case stripes
        case filled
    }
    
}
