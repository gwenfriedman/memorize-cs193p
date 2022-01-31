//
//  Theme.swift
//  Memorize
//
//  Created by Gwen Friedman on 1/28/22.
//

import Foundation

struct Theme {
    var name: String
    var emojis: [String]
    var numberOfPairs: Int
    var color: String
    
    init(name: String, emojis: [String], numberOfPairs: Int, color: String) {
        self.name = name
        self.emojis = emojis
        self.numberOfPairs = numberOfPairs > emojis.count ? emojis.count : numberOfPairs
        self.color = color
    }
}
