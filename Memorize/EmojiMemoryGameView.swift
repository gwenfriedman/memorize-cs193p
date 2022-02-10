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
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90)).padding(DrawingConstants.circlePadding).opacity(DrawingConstants.circleOpacity)
                    Text(card.content)
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                        .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                        .font(Font.system(size: DrawingConstants.fontSize))
                        .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        })
    }
    
    private func scale(thatFits size:CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min( size.width, size.height) * DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.7
        static let circlePadding: CGFloat = 6
        static let circleOpacity: Double = 0.5
        static let fontSize: CGFloat = 32
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

