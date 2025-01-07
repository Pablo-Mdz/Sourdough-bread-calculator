//
//  HomeView.swift
//  Sourdough-bread-calculator
//
//  Created by Pablo Cigoy on 07.01.25.
//
import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome!")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                
                Text("Start exploring our bread & patisserie recipes")
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                
                // Ejemplo: algún icono o imagen
                Image(systemName: "bag.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color.white) // fondo blanco
            .navigationTitle("Home")
        }
    }
}
