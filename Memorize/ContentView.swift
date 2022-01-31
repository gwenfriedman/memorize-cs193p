//
//  ContentView.swift
//  Memorize
//
//  Created by Gwen Friedman on 1/18/22.
//

import SwiftUI

struct ContentView: View {
    //when something changes, update UI
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        
        VStack{
            
            HStack {
                Text("Theme: \(viewModel.themeName)")
                Text("Score: \(viewModel.score)")
            }
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio( 2/3, contentMode: .fit)
                            .onTapGesture {
                                //Intent to choose a card
                                viewModel.choose(card)
                            }
                
                    }
                }
            }
            .foregroundColor(viewModel.color)
            .padding(.horizontal)
            
            Button {
                viewModel.newGame()
            } label: {
                Text("New Game")
            }
        }
        .padding(.horizontal)
    }
}


struct CardView: View {
    let card: MemoryGame<String>.Card
    var body: some View {
        //Don't need the parentheses or the label because it's a function
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
            //no way to stroke and fill a rounded rectangle
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        //You can add more previews here
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
    }
}

