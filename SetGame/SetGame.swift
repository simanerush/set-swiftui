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
        return model.cards
    }
}
