//
//  BreadView.swift
//  Sourdough-bread-calculator
//
//  Created by Pablo Cigoy on 07.01.25.
//

import SwiftUI

struct BreadView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Bread Section")
                    .font(.title)
                    .foregroundColor(.black)
                
                // Aquí podrías colocar tu lista de panes, tarjetas, etc.
                
                Spacer()
            }
            .padding()
            .background(Color.white)
            .navigationTitle("Bread")
        }
    }
}




