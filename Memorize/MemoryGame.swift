//
//  MemoryGame.swift
//  Memorize
//
//  Created by Gwen Friedman on 1/25/22.
//

//Model

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private(set) var score: Int = 0
    
    private var indexOfFaceUpCard: Int?
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else {
                    if cards[chosenIndex].alreadySeen || cards[potentialMatchIndex].alreadySeen {
                        score -= 1
                    }
                }
                indexOfFaceUpCard = nil
            } else {
                cards[chosenIndex].alreadySeen = true
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                indexOfFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        var exisitingContent: [CardContent] = []
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            if(!exisitingContent.contains(content)) {
                cards.append(Card(content: content, id: pairIndex*2))
                cards.append(Card(content: content, id: pairIndex*2 + 1))
            }
            exisitingContent.append(content)
        }
        cards.shuffle()
        
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var alreadySeen: Bool = false
        var id: Int
    }
    
}
