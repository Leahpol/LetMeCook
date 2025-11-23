//
//  NavigationBar.swift
//  LetMeCook
//
//  Created by Leah Polonsky on 11/22/25.
//

import SwiftUI

struct NavigationBar: View {
    @State private var isPresentingAddRecipeSheet = false
    @Binding var recipes: [Recipe]
    var body: some View {
        ZStack {
                Color("BackgroundColor")
                        .ignoresSafeArea()
         
        ZStack {
            HStack (spacing: 0) {
                NavigationLink(destination: ExplorePageView(recipes: $recipes)) {
                    Text("Explore Recipies")
                        .font(.system(size: 23, weight: .medium))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, maxHeight: 120)
                        .background(Color.white.opacity(0.9))
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        .overlay(RoundedRectangle(cornerRadius: 15, style: .continuous).stroke(Color.black.opacity(0.5), lineWidth: 2))
                }
                .ignoresSafeArea(edges: .bottom)
                .offset(y: +372)
                
                NavigationLink(destination: MyCookBookView(recipes: $recipes)) {
                    Text("My CookBook")
                        .font(.system(size: 23, weight: .medium))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, maxHeight: 120)
                        .background(Color.white.opacity(0.9))
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                        .overlay(RoundedRectangle(cornerRadius: 15, style: .continuous).stroke(Color.black.opacity(0.5), lineWidth: 2))
                }
                .ignoresSafeArea(edges: .bottom)
                .offset(y: +372)
            }
            Button(action: {
                isPresentingAddRecipeSheet.toggle()
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.black)
                    .font(.system(size: 30, weight: .medium))
                    .padding()
                    .background(Color.white.opacity(1))
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.black.opacity(0.5), lineWidth: 2))
            }
            .offset(y: 325)
        }
        .sheet(isPresented: $isPresentingAddRecipeSheet) {
            AddRecipeView(recipes: $recipes)
        }
    }
}
   
}

#Preview {
    NavigationBarPreviewWrapper()
}

struct NavigationBarPreviewWrapper: View {
    @State private var recipes = [Recipe]()
    

    var body: some View {
        NavigationBar(recipes: $recipes)
    }
}
