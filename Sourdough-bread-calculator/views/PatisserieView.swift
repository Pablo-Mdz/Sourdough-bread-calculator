//
//  PatisserieView.swift
//  Sourdough-bread-calculator
//
//  Created by Pablo Cigoy on 07.01.25.
//
import SwiftUI

struct PatisserieView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Patisserie Section")
                    .font(.title)
                    .foregroundColor(.black)
                
                // Aquí tu contenido de pastelería
                
                Spacer()
            }
            .padding()
            .background(Color.white)
            .navigationTitle("Patisserie")
        }
    }
}
