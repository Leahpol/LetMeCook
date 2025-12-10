//
//  NavigationBar.swift
//  LetMeCook
//
//  Created by Leah Polonsky on 11/22/25.
//
import SwiftUI
import SwiftData
import Combine
struct NavigationBar: View {
    @State private var isPresentingAddRecipeSheet = false
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
     
            ZStack {
                HStack (spacing: 0) {
                    NavigationLink(destination: MyFridgeView()) {
                        Text("My Fridge")
                            .font(.system(size: 23, weight: .medium))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, maxHeight: 120)
                            .background(Color.white.opacity(0.9))
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            .shadow(radius: 4, y: 2)

                            
                    }
                    .ignoresSafeArea(edges: .bottom)
                    .offset(y: +372)
                    
                    NavigationLink(destination: MyCookBookView()) {
                        Text("My CookBook")
                            .font(.system(size: 23, weight: .medium))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, maxHeight: 120)
                            .background(Color.white.opacity(0.9))
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            .shadow(radius: 4, y: 2)

                           
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
                        .shadow(radius: 4, y: 2)

                        
                }
                .offset(y: 325)
            }
            .sheet(isPresented: $isPresentingAddRecipeSheet) {
                AddRecipeView()
            }
        }
    }
}
#Preview {
    NavigationBar()
        .modelContainer(for: Recipe.self)
}

