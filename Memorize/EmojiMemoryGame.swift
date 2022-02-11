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
    
    typealias Card = MemoryGame<String>.Card
    
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in theme.emojis[pairIndex]}
    }
    
    //private - only the view model's code can see the model, protects the model from changes
    //private(set) - can look at the model, but can't change it
    @Published private var model = createMemoryGame(theme: themes[0])
    
    private(set) var theme: Theme
    
    init() {
            theme = EmojiMemoryGame.themes.randomElement()!
            theme.emojis.shuffle()
            model = EmojiMemoryGame.createMemoryGame(theme: theme)
        }
        
    static var themes: [Theme] = [
        Theme(name: "flags", emojis: ["🏴‍☠️", "🏳️‍🌈", "🇨🇦", "🇬🇷", "🇯🇵", "🇳🇱", "🇺🇸", "🏁", "🇮🇱", "🇵🇼", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇦🇸", "🇮🇪"], numberOfPairs: 10, color: "green"),
        Theme(name: "vehicles", emojis: ["🚲", "🚚", "🛴", "✈️", "🚘", "🛳", "🚀", "🚁"], numberOfPairs: 12, color: "red"),
        Theme(name: "animals", emojis: ["🐶", "🐱", "🐭", "🦊", "🐼", "🐤", "🐸", "🐌", "🐝", "🐍", "🦀"], numberOfPairs: 11, color: "yellow"),
        Theme(name: "flowers", emojis: ["🌺", "🌸", "🌼", "🌻"], numberOfPairs: 4, color: "pink"),
        Theme(name: "weather", emojis: ["🌈", "🌨", "☔️", "☀️", "🌪"], numberOfPairs: 5, color: "blue"),
        Theme(name: "fruit", emojis: ["🍎", "🍐", "🍌", "🍉", "🍓"], numberOfPairs: 5, color: "purple")
    ]
    
    //if model is private, use this - don't need if private(set)
    var cards: Array<Card> {
        return model.cards
    }
    
    var themeName: String {
        theme.name
    }
    
    var score: Int {
        model.score
    }
    
    var color: Color  {
        switch theme.color {
        case "blue":
            return .blue
        case "red":
            return .red
        case "green":
            return .green
        case "purple":
            return .purple
        case "yellow":
            return .yellow
        case "pink":
            return .pink
        default:
            return .black
        }
    }
    
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func newGame() {
        theme = EmojiMemoryGame.themes.randomElement()!
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
}

