//
//  BreadView.swift
//  Sourdough-bread-calculator
//
//  Created by Pablo Cigoy on 07.01.25.
//

import SwiftUI

struct BreadView: View {
    @ObservedObject private var viewModel = RecipesViewModel()

    var body: some View {
        NavigationView {
            VStack(alignment: .trailing, spacing: 16) {
                Text("Bread Section")
                    .font(.title)
                    .foregroundColor(.black)
                
                NavigationLink(destination: AddBreadView()) {
                    Text("Add New Bread")
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                
                // La lista de recetas, dentro del mismo VStack
                List(viewModel.recipes) { recipe in
                    Text(recipe.name)
                }
            }
            .padding()
            .navigationTitle("Bread")
        }
        .onAppear {
            viewModel.loadRecipes()
        }
    }
}

#Preview {
    BreadView()
}


