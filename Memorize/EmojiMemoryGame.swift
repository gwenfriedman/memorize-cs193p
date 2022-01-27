//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Gwen Friedman on 1/25/22.
//

//ModelView
//Part of the UI

import SwiftUI

class EmojiMemoryGame : ObservableObject {
    //connection to the model
    //create its own model - not always the case for a ViewModel (ex when it's a database)
    
    //error because this is an instance member - need to add static
    static let vehicleEmojis = ["🚲", "🚚", "🛴", "✈️", "🚘", "🛳", "🚀", "🚁"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in vehicleEmojis[pairIndex]}
    }
    
    //private - only the view model's code can see the model, protects the model from changes
    //private(set) - can look at the model, but can't change it
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    //if model is private, use this - don't need if private(set)
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    //need to include EmojiMemoryGame
//    func foo() {
//        let x = EmojiMemoryGame.vehicleEmojis
//    }
    
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}

