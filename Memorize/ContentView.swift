//
//  ContentView.swift
//  Memorize
//
//  Created by Gwen Friedman on 1/18/22.
//

import SwiftUI

struct ContentView: View {
    // type could  be Array<String> or [String]
    
    var vehicleEmojis = ["🚲", "🚚", "🛴", "✈️", "🚘", "🛳", "🚀", "🚁"]
    var animalEmojis = ["🐶", "🐱", "🐭", "🦊", "🐼", "🐤", "🐸", "🐌", "🐝", "🐍", "🦀"]
    
    var flagEmojis = ["🏴‍☠️", "🏳️‍🌈", "🇨🇦", "🇬🇷", "🇯🇵", "🇳🇱", "🇺🇸", "🏁", "🇮🇱", "🇵🇼", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇦🇸", "🇮🇪"]
    
    @State var emojis = ["🚲", "🚚", "🛴", "✈️", "🚘", "🛳", "🚀", "🚁"]
    
    
    @State var emojiCount: Int = 8
    
    var body: some View {
        
        VStack{
            Text("Memorize!")
                .font(.title)
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
                VStack{
                    vehicle
                    Text("vehicles")
                        .font(.body)
                        .foregroundColor(Color.blue)
                }
                
                //will grab as much room as it can
                Spacer()
                
                VStack{
                    animal
                    Text("animals")
                        .font(.body)
                        .foregroundColor(Color.blue)
                }
                
                Spacer()
                
                VStack{
                    flag
                    Text("flags")
                        .font(.body)
                        .foregroundColor(Color.blue)
                }
                
            }
            .padding(.horizontal)
            .font(.largeTitle)
        }
        .padding(.horizontal)
            
    }
    
    var vehicle: some View {
        Button {
            emojis = vehicleEmojis.shuffled()
            emojiCount = emojis.count
        } label: {
            Image(systemName: "car")
        }
    }
    
    var animal: some View {
        Button {
            emojis = animalEmojis.shuffled()
            emojiCount = emojis.count
        } label: {
            Image(systemName: "hare")
        }
    }
    
    var flag: some View {
        Button {
            emojis = flagEmojis.shuffled()
            emojiCount = emojis.count
        } label: {
            Image(systemName: "flag")
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

