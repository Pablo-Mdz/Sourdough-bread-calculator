//
//  Recipe.swift
//  Sourdough-bread-calculator
//
//  Created by Pablo Cigoy on 06/01/2025.
//

struct Recipe: Identifiable, Codable {
    let id: String
    let name: String
    let breadsPerRecipe: Int  // Cantidad estándar (por ej. 10 panes)
    let description: String
    var ingredients: [String: Ingredient]
    // Podríamos tener un timer para cada paso; si no se usa, es nil o 0
    var timeInMinutes: Int?
    // Indica si esta receta maneja autólisis (para mostrárselo al usuario, timers, etc.)
    let hasAutolysis: Bool
    
    /// Recalcula la cantidad de cada ingrediente para la cantidad seleccionada
        func calculateIngredients(for quantity: Int) -> [String: Ingredient] {
            var recalculatedIngredients = ingredients
            for (key, ingredient) in ingredients {
                var newIngredient = ingredient
                newIngredient.amount = ingredient.getAmount(for: quantity, breadsPerRecipe: breadsPerRecipe)
                recalculatedIngredients[key] = newIngredient
            }
            return recalculatedIngredients
        }
}


struct Ingredient: Identifiable, Codable {
    let id: String
    var name: String
    var amount: Double
    var unit: String
    let standardAmounts: [Int: Double]
    
    
    func getAmount(for quantity: Int, breadsPerRecipe: Int) -> Double {
        if let exactAmount = standardAmounts[quantity] {
            return exactAmount
        }
        let baseFactor = Double(quantity) / Double(breadsPerRecipe)
        // Redondeo a 3 decimales para evitar floats exagerados
        return (amount * baseFactor * 1000).rounded() / 1000
    }
}
