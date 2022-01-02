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
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            if card.isMatched && card.isFaceUp {
                let _ = print("here")
                Rectangle().opacity(0)
            } else {
                CardView(card: card)
                    .padding(4)
                    .aspectRatio(2/3, contentMode: .fit)
                    .onTapGesture {
                        game.choose(card)
                    }
            }
        }
        
        .foregroundColor(.red)
        .padding(.horizontal)
    }
}

struct CardView: View {
    let card: Game.Card
    let enumToSystem = [Game.Shapes.rectangle: "capsule.portrait", Game.Shapes.diamond: "rhombus", Game.Shapes.tilda: "bolt", Game.Colors.purple: SwiftUI.Color.purple, Game.Colors.red: SwiftUI.Color.red, Game.Colors.green: SwiftUI.Color.green] as [AnyHashable : Any]
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                
                if card.count == 2 {
                    if card.pattern == Game.Patterns.filled {
                        HStack {
                            Image(systemName: enumToSystem[card.shape]! as! String + ".fill").foregroundColor(enumToSystem[card.color]! as? SwiftUI.Color)
                            Image(systemName: enumToSystem[card.shape]! as! String + ".fill").foregroundColor(enumToSystem[card.color]! as? SwiftUI.Color)
                        }
                    } else if card.pattern == Game.Patterns.stripes {
                        HStack {
                            Image(systemName: enumToSystem[card.shape]! as! String ).foregroundColor(enumToSystem[card.color]! as? SwiftUI.Color).opacity(0.5)
                            Image(systemName: enumToSystem[card.shape]! as! String).foregroundColor(enumToSystem[card.color]! as? SwiftUI.Color).opacity(0.5)
                        }
                    } else {
                        HStack {
                            Image(systemName: enumToSystem[card.shape]! as! String ).foregroundColor(enumToSystem[card.color]! as? SwiftUI.Color)
                            Image(systemName: enumToSystem[card.shape]! as! String).foregroundColor(enumToSystem[card.color]! as? SwiftUI.Color)
                        }
                    }
                    
                } else if card.count == 3 {
                    if card.pattern == Game.Patterns.filled {
                        HStack {
                            Image(systemName: enumToSystem[card.shape]! as! String + ".fill").foregroundColor(enumToSystem[card.color]! as? SwiftUI.Color)
                            Image(systemName: enumToSystem[card.shape]! as! String + ".fill").foregroundColor(enumToSystem[card.color]! as? SwiftUI.Color)
                            Image(systemName: enumToSystem[card.shape]! as! String + ".fill").foregroundColor(enumToSystem[card.color]! as? SwiftUI.Color)
                        }
                    } else if card.pattern == Game.Patterns.stripes {
                        HStack {
                            Image(systemName: enumToSystem[card.shape]! as! String ).foregroundColor(enumToSystem[card.color]! as? SwiftUI.Color).opacity(0.5)
                            Image(systemName: enumToSystem[card.shape]! as! String).foregroundColor(enumToSystem[card.color]! as? SwiftUI.Color).opacity(0.5)
                            Image(systemName: enumToSystem[card.shape]! as! String).foregroundColor(enumToSystem[card.color]! as? SwiftUI.Color).opacity(0.5)
                        }
                    } else {
                        HStack {
                            Image(systemName: enumToSystem[card.shape]! as! String ).foregroundColor(enumToSystem[card.color]! as? SwiftUI.Color)
                            Image(systemName: enumToSystem[card.shape]! as! String).foregroundColor(enumToSystem[card.color]! as? SwiftUI.Color) 
                            Image(systemName: enumToSystem[card.shape]! as! String).foregroundColor(enumToSystem[card.color]! as? SwiftUI.Color)
                        }
                    }
                } else {
                    if card.pattern == Game.Patterns.filled {
                        
                        Image(systemName: enumToSystem[card.shape]! as! String + ".fill").foregroundColor(enumToSystem[card.color]! as? SwiftUI.Color)
                        
                    } else if card.pattern == Game.Patterns.stripes {
                        
                        Image(systemName: enumToSystem[card.shape]! as! String ).foregroundColor(enumToSystem[card.color]! as? SwiftUI.Color).opacity(0.5)
                        
                    } else {
                        
                        Image(systemName: enumToSystem[card.shape]! as! String ).foregroundColor(enumToSystem[card.color]! as? SwiftUI.Color)
                        
                    }
                }
                
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
.previewInterfaceOrientation(.portrait)
    }
}
