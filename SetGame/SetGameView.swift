//
//  SetGameView.swift
//  SetGame
//
//  Created by Serafima Nerush on 12/28/21.
//

import SwiftUI

struct SetGameView: View {
    
    @ObservedObject var game: SetGame
    
    @State private var showingButtonAlert = false
    
    @Namespace private var dealingNamespace
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button("Rules") {
                        showingButtonAlert = true
                        
                    }
                    .alert(isPresented: $showingButtonAlert) {
                        Alert(title: Text("Rules of Set"), message: Text("You have to choose 3 cards. They are a set if:  \n1. They have the same count or three different counts. \n2. They have the same shape or have three different shapes. \n3. They have the same pattern or three different patterns. \n4. They all have the same color or three different colors."), dismissButton: .cancel())
                    }
                    Spacer()
                    Button("New Game") {
                        game.startNewGame()
                    }
                    
                }
                .padding()
                
                gameBody
                deckBody
            }
        }
        
            
    }
    
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: Game.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: Game.Card) -> Bool {
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: Game.Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * (CardConstants.totalDealDuration / Double(game.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: Game.Card) -> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    var gameBody: some View {
        GeometryReader { geometry in
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                if card.isMatched && card.isFaceUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card)
                        .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                        .padding(4)
                        .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                        .zIndex(zIndex(of: card))
                        .padding(4)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }
        }
        
        
        
        .foregroundColor(.red)
        .padding(.horizontal)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(CardConstants.color)
        .onTapGesture {
            // "deal" cards
            for card in game.cards {
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    private struct CardConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidth = undealtHeight * aspectRatio
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
