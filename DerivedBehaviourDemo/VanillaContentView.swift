//
//  VanillaContentView.swift
//  DerivedBehaviourDemo
//
//  Created by Sasikumar JP on 15/04/23.
//

import SwiftUI

struct VanillaContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VanillaContentView()
    }
}
