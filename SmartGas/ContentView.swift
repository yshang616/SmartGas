//
//  ContentView.swift
//  SmartGas
//
//  Created by EmilyShang on 2020/9/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        Text("SmartGas")
            .font(.largeTitle)
            .multilineTextAlignment(.leading)
            .padding().position(x:240,y:400)

        Image("Group 1").position(x: 200, y: 200)

    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDisplayName("Launch Page")
            .preferredColorScheme(.dark)
    }
}
