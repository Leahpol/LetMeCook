//
//  SwiftUIView.swift
//  LetMeCook
//
//  Created by Leah Polonsky on 11/21/25.
//

import SwiftUI

struct ContentView: View {
    @State private var recipes: [Recipe] = []
    var body: some View {
        NavigationStack {
                    ZStack {
                        NavigationBar(recipes: $recipes)

                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 40))
                            .offset(y: -100)
                    }
                }
    }
}

#Preview {
    ContentView()
}

