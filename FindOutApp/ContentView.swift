//
//  ContentView.swift
//  FindOutApp
//
//  Created by cmStudent on 2024/09/30.
//

import SwiftUI

struct ContentView: View {
    @State private var MoveToMapView:Bool = false
    var body: some View {
        VStack {
            Button(action : {
                MoveToMapView = true
            }) {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
            }
            Text("Hello, world!")
        }
        .padding()
        .fullScreenCover(isPresented: $MoveToMapView) {
            BaseMapView()
        }
    }
}

#Preview {
    ContentView()
}
