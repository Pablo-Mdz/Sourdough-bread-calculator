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
    
    func loadRecipes() {
        Task {
            let fetched = await repository.fetchRecipes()
            self.recipes = fetched
        }
    }
    
    func addRecipe(_ recipe: Recipe) {
        do {
            try repository.addRecipe(recipe)
        } catch {
            print("Error al agregar la receta: \(error)")
        }
    }
    
    func calculateIngredients(of recipe: Recipe, for quantity: Int) -> [Ingredient] {
        let breadsPerRecipe = recipe.breadsPerRecipe
        
        return recipe.ingredients.map { ingredient in
            var newIngredient = ingredient
            newIngredient.amount = getAmount(for: ingredient, quantity: quantity, breadsPerRecipe: breadsPerRecipe)
            return newIngredient
        }
    }
    // get ingredient ammounts
    func getAmount(for ingredient: Ingredient, quantity: Int, breadsPerRecipe: Int) -> Double {
          if let exactAmount = ingredient.standardAmounts[quantity] {
              return exactAmount
          }
          let baseFactor = Double(quantity) / Double(breadsPerRecipe)
          return (ingredient.amount * baseFactor * 1000).rounded() / 1000
      }
}
