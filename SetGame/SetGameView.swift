//
//  SetGameView.swift
//  SetGame
//
//  Created by Serafima Nerush on 12/28/21.
//

import SwiftUI

struct SetGameView: View {
    
    @ObservedObject var game: SetGame
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGame()
        return SetGameView(game: game)
    }
}
