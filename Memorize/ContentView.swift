//
//  ContentView.swift
//  Memorize
//
//  Created by Gwen Friedman on 1/18/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        //Don't need the parentheses or the label because it's a function
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 3)
            Text("Hello, world!")
                //overrides the foreground color of the ZStack
                .foregroundColor(Color.orange)
        }
        .padding(.horizontal)
        .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
