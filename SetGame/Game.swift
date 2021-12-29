//
//  Game.swift
//  Game
//
//  Created by Serafima Nerush on 12/28/21.
//

import Foundation

struct Game {
    
    private(set) var cards: Array<Card>
    
    init() {
        cards = []
        for _ in 1...27 {
            cards.append(Card(color: Colors.red, shape: Shapes.diamond, pattern: Patterns.plain))
        }
        for card in cards {
            
        }
    }
    
    struct Card {
        var color: Colors
        var shape: Shapes
        var pattern: Patterns
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
