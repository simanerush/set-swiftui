//
//  SetGameApp.swift
//  SetGame
//
//  Created by Serafima Nerush on 12/28/21.
//

import SwiftUI

@main
struct SetGameApp: App {
    let game = SetGame()
    var body: some Scene {
        WindowGroup {
            SetGameView(game: game)
        }
    }
}
