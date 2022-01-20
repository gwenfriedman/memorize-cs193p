//
//  ContentView.swift
//  Memorize
//
//  Created by Gwen Friedman on 1/18/22.
//

import SwiftUI

struct ContentView: View {
    // type could  be Array<String> or [String]
    var emojis = ["🚲", "🚚", "🛴", "✈️", "🚘", "🛳", "🚀", "🚁", "a", "b", "c", "d", "e", "f"]
    
    @State var emojiCount: Int = 4
    
    var body: some View {
        
        VStack{
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio( 2/3, contentMode: .fit)
                
                    }
                }
            }
            .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
            Spacer(minLength: 20)
            HStack{
                remove
                
                //will grab as much room as it can
                Spacer()
                
                add
            }
            .padding(.horizontal)
            .font(.largeTitle)
        }
        .padding(.horizontal)
            
    }
    
    var remove: some View {
        Button {
            if emojiCount > 1 {
                emojiCount -= 1
            }
        } label: {
            Image(systemName: "minus.circle")
        }
    }
    
    var add: some View {
        Button {
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        } label: {
            Image(systemName: "plus.circle")
        }
    }
}


struct CardView: View {
    
    //if default value is set, the passed value will override it
    //vars are immutable, add @State
    //@State makes it a pointer to a var somewhere else
    @State var isFaceUp: Bool = true
    var content: String
    
    var body: some View {
        //Don't need the parentheses or the label because it's a function
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
            //no way to stroke and fill a rounded rectangle
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //You can add more previews here
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}

