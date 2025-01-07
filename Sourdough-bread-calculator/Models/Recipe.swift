//
//  Recipe.swift
//  Sourdough-bread-calculator
//
//  Created by Pablo Cigoy on 06/01/2025.
//

struct Recipe: Identifiable, Codable {
    let id: String
    let name: String
    let breadsPerRecipe: Int
    let description: String
    var ingredients: [Ingredient]
    var timeInMinutes: Int?
    let hasAutolysis: Bool
    
}



