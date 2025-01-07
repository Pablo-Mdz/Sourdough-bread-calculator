//
//  Ingredient.swift
//  Sourdough-bread-calculator
//
//  Created by Pablo Cigoy on 07.01.25.
//


struct Ingredient: Identifiable, Codable {
    let id: String
    var name: String
    var amount: Double
    var unit: String
    let standardAmounts: [Int: Double]
    
    
}
