//
//  RecipesViewModel.swift
//  Sourdough-bread-calculator
//
//  Created by Pablo Cigoy on 07.01.25.
//

import SwiftUI
import Combine

@MainActor
class RecipesViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    
    private let repository = RecipeRepository()
    
    // Cargar todas las recetas existentes
    func loadRecipes() {
        Task {
            let fetched = await repository.fetchRecipes()
            self.recipes = fetched
        }
    }
    
    // Agregar una nueva receta
    func addRecipe(_ recipe: Recipe) {
        do {
            try repository.addRecipe(recipe)
            // Si no usas un listener, puedes refrescar la lista manualmente:
            // self.loadRecipes()
        } catch {
            print("Error al agregar la receta: \(error)")
        }
    }
}
