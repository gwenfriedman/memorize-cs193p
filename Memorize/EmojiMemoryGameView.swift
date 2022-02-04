//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Gwen Friedman on 1/18/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    //when something changes, update UI
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        
        VStack{
            
            HStack {
                Text("Theme: \(game.themeName)")
                Text("Score: \(game.score)")
            }
            
            AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
                CardView(card)
                    .padding(4)
                    .onTapGesture {
                        //Intent to choose a card
                        game.choose(card)
                    }
            })
            .foregroundColor(game.color)
            .padding(.horizontal)
            
            Button {
                game.newGame()
            } label: {
                Text("New Game")
            }
        }
        .padding(.horizontal)
    }
}


struct CardView: View {
    private let card: EmojiMemoryGame.Card
    
    init(_ card: EmojiMemoryGame.Card) {
        self.card = card
    }
    
    var body: some View {
        
        
        GeometryReader(content: { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                //no way to stroke and fill a rounded rectangle
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90)).padding(DrawingConstants.circlePadding).opacity(DrawingConstants.circleOpacity)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        })
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min( size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.7
        static let circlePadding: CGFloat = 6
        static let circleOpacity: Double = 0.5
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        //You can add more previews here
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.dark)
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
    }
}

