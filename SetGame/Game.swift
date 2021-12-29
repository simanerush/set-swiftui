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
                cards[i].pattern = Game.Patterns.plain
                cards[i + 1].pattern = Game.Patterns.plain
                cards[i + 2].pattern = Game.Patterns.plain
            }
            if i % 3 == 1 {
                cards[i].count = 2
                cards[i].pattern = Game.Patterns.stripes
                if i < 80 {
                    cards[i + 1].pattern = Game.Patterns.stripes
                }
                if i < 79 {
                    cards[i + 2].pattern = Game.Patterns.stripes
                }
            }
            if i % 3 == 2 {
                cards[i].count = 3
                cards[i].pattern = Game.Patterns.filled
                if i < 80 {
                    cards[i + 1].pattern = Game.Patterns.filled
                }
                if i < 79 {
                    cards[i + 2].pattern = Game.Patterns.filled
                }
                
            }
        }
        
        var countRed = 0
        var countGreen = 0
        var countPurple = 0
        for card in cards {
            if card.color == Game.Colors.green {
                countGreen += 1
            }
            if card.color == Game.Colors.purple {
                countPurple += 1
            }
            if card.color == Game.Colors.red {
                countRed += 1
            }
        }
        
        print("red: \(countRed)")
        print("green: \(countGreen)")
        print("purple: \(countPurple)")
        print(cards)
        
    }
    
    struct Card: Identifiable {
        var color: Colors
        var shape: Shapes
        var pattern: Patterns
        var count: Int
        var isFaceUp = true
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
