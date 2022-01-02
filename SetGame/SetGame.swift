//
//  SetGame.swift
//  SetGame
//
//  Created by Serafima Nerush on 12/28/21.
//

import SwiftUI

class SetGame: ObservableObject {
    
    static func createSetGame() -> Game {
        Game()
    }
    
    @Published private var model: Game = createSetGame()
    
    var cards: Array<Game.Card> {
        if model.addMoreCards {
            model.addMoreCards = false
            return Array(model.cards[0...model.numberOfCardsToBeAdded])
        }
        
        return Array(model.cards[0...model.numberOfCardsToBeAdded])
    }
    
    func choose(_ card: Game.Card) {
        model.choose(card)
    }
}
