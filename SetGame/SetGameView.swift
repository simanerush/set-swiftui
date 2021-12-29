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
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))]) {
                ForEach(game.cards) { card in
                    CardView(card: card)
                    .aspectRatio(3/2, contentMode: .fit)
                }
            }
        }
    }
}

struct CardView: View {
    let card: Game.Card
    let enumToSystem = [Game.Shapes.rectangle: "capsule.portrait", Game.Shapes.diamond: "rhombus", Game.Shapes.tilda: "triangle", Game.Colors.purple: SwiftUI.Color.purple, Game.Colors.red: SwiftUI.Color.red, Game.Colors.green: SwiftUI.Color.green] as [AnyHashable : Any]
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                
                if card.count == 2 {
                    HStack {
                        Image(systemName: enumToSystem[card.shape]! as! String).foregroundColor(enumToSystem[card.color]! as? SwiftUI.Color)
                        Image(systemName: enumToSystem[card.shape]! as! String).foregroundColor(enumToSystem[card.color]! as? SwiftUI.Color)
                    }
                } else if card.count == 3 {
                    HStack {
                        Image(systemName: enumToSystem[card.shape]! as! String).foregroundColor(enumToSystem[card.color]! as? SwiftUI.Color)
                        Image(systemName: enumToSystem[card.shape]! as! String).foregroundColor(enumToSystem[card.color]! as? SwiftUI.Color)
                        Image(systemName: enumToSystem[card.shape]! as! String).foregroundColor(enumToSystem[card.color]! as? SwiftUI.Color)
                    }
                } else {
                    Image(systemName: enumToSystem[card.shape]! as! String).foregroundColor(enumToSystem[card.color]! as? SwiftUI.Color)
                }
                
                
                
//                switch card.shape {
//                case Game.Shapes.diamond:
//                    switch card.color {
//                    case Game.Colors.red:
//                        switch card.count {
//                        case 2:
//                            HStack {
//                                Image(systemName: "capsule.portrait").foregroundColor(.red)
//                                Image(systemName: "capsule.portrait").foregroundColor(.red)
//                            }
//                        case 3:
//                            HStack {
//                                Image(systemName: "capsule.portrait").foregroundColor(.red)
//                                Image(systemName: "capsule.portrait").foregroundColor(.red)
//                                Image(systemName: "capsule.portrait").foregroundColor(.red)
//                            }
//                        default:
//                            Image(systemName: "capsule.portrait").foregroundColor(.red)
//                        }
//                    case Game.Colors.purple:
//                        switch card.count {
//                        case 2:
//                            HStack {
//                                Image(systemName: "capsule.portrait").foregroundColor(.purple)
//                                Image(systemName: "capsule.portrait").foregroundColor(.purple)
//                            }
//                        case 3:
//                            HStack {
//                                Image(systemName: "capsule.portrait").foregroundColor(.purple)
//                                Image(systemName: "capsule.portrait").foregroundColor(.purple)
//                                Image(systemName: "capsule.portrait").foregroundColor(.purple)
//                            }
//                        default:
//                            Image(systemName: "capsule.portrait").foregroundColor(.purple)
//                        }
//                    case Game.Colors.green:
//                        Image(systemName: "capsule.portrait").foregroundColor(.green)
//                    }
//                case Game.Shapes.tilda:
//                    switch card.color {
//                    case Game.Colors.red:
//                        Image(systemName: "triangle").foregroundColor(.red)
//                    case Game.Colors.purple:
//                        Image(systemName: "triangle").foregroundColor(.purple)
//                    case Game.Colors.green:
//                        Image(systemName: "triangle").foregroundColor(.green)
//                    }
//                case Game.Shapes.rectangle:
//                    switch card.color {
//                    case Game.Colors.red:
//                        Image(systemName: "rhombus").foregroundColor(.red)
//                    case Game.Colors.purple:
//                        Image(systemName: "rhombus").foregroundColor(.purple)
//                    case Game.Colors.green:
//                        Image(systemName: "rhombus").foregroundColor(.green)
//                    }
//                }
            
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}

private struct DrawingConstants {
    static let cornerRadius: CGFloat = 20
    static let lineWidth: CGFloat = 3
    static let fontScale: CGFloat = 0.8
}
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGame()
        return SetGameView(game: game)
    }
}
