//
//  Recipe.swift
//  Sourdough-bread-calculator
//
//  Created by Pablo Cigoy on 06/01/2025.
//

struct Recipe: Identifiable, Codable {
    let id: String
    let name: String
    let standardQuantity: Int  // Standar quantity (10 brads)
    let availableQuantities: [Int]  // [10, 11, 12, 13, etc.]
    let steps: [String: Step]
    let hasAutolysis: Bool
    
    // to calculate how many breads
    func calculateIngredients(for quantity: Int) -> [String: Step] {
        var calculatedSteps = steps
        for (stepKey, step) in steps {
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
    var ingredients: [String: Ingredient]
    let timeInMinutes: Int?
}

struct Ingredient: Identifiable, Codable {
    let id: String
    let name: String
    var amount: Double
    let unit: String
    let standardAmounts: [Int: Double]  // [10: 1.837, 11: 2.096, 12: 2.286, etc.]
    
    // Obtain specific quantity of breads
    func getAmount(for quantity: Int, standardQuantity: Int) -> Double {
        if let exactAmount = standardAmounts[quantity] {
            return exactAmount
        }
        
        let baseFactor = Double(quantity) / Double(standardQuantity)
              return (amount * baseFactor * 1000).rounded() / 1000  // Redondeo a 3 decimales
    }
}
