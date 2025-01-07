//
//  ContentView.swift
//  Sourdough-bread-calculator
//
//  Created by Pablo Cigoy on 06/01/2025.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            BreadView()
                .tabItem {
                    Label("Bread", systemImage: "leaf.fill")
                }
            
            PatisserieView()
                .tabItem {
                    Label("Patisserie", systemImage: "cup.and.saucer.fill")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .accentColor(.black)
        .background(Color.white.ignoresSafeArea())
    }
}

#Preview {
    ContentView()
}
