//
//  Recipe.swift
//  Sourdough-bread-calculator
//
//  Created by Pablo Cigoy on 06/01/2025.
//
struct Recipe: Identifiable, Codable {
    let id: String
    let name: String
    let standardQuantity: Int  // Cantidad estándar (por ej. 10 panes)
    let availableQuantities: [Int]
    
    // Indica si esta receta maneja autólisis (para mostrárselo al usuario, timers, etc.)
    let hasAutolysis: Bool
    
    // Diccionario donde la key podría ser "step_autolisis", "step_principal", etc.
    let steps: [String: Step]
    
    func calculateIngredients(for quantity: Int) -> [String: Step] {
        var calculatedSteps = steps
        for (stepKey, step) in steps {
            // Se recalculan las cantidades de los ingredientes
            calculatedSteps[stepKey]?.ingredients = step.ingredients.mapValues { ingredient in
                var newIngredient = ingredient
                newIngredient.amount = ingredient.getAmount(for: quantity, standardQuantity: standardQuantity)
                return newIngredient
            }
        }
        return calculatedSteps
    }
}

struct Step: Identifiable, Codable {
    let id: String
    let name: String
    let order: Int
    
    // Diccionario de ingredientes; la key puede ser el id `"harina"`, `"agua"`, `"sal"`, etc.
    var ingredients: [String: Ingredient]
    
    // Podríamos tener un timer para cada paso; si no se usa, es nil o 0
    let timeInMinutes: Int?
}

struct Ingredient: Identifiable, Codable {
    let id: String               // Ej: "harina"
    let name: String             // Ej: "Harina de trigo 550"
    var amount: Double           // Cantidad base para la standardQuantity
    let unit: String             // Ej: "g", "ml"
    
    // Para cantidades estándar específicas, ej: [10: 500, 11: 550, 12: 600]
    let standardAmounts: [Int: Double]
    
    func getAmount(for quantity: Int, standardQuantity: Int) -> Double {
        if let exactAmount = standardAmounts[quantity] {
            return exactAmount
        }
        
        let baseFactor = Double(quantity) / Double(standardQuantity)
        // Redondeo a 3 decimales para evitar floats exagerados
        return (amount * baseFactor * 1000).rounded() / 1000
    }
}
