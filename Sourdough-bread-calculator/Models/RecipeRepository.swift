//
//  RecipeRepository.swift
//  Sourdough-bread-calculator
//
//  Created by Pablo Cigoy on 07.01.25.
//


import Foundation
import FirebaseFirestore
//import FirebaseFirestoreSwift

class RecipeRepository: ObservableObject {
    private let db = Firestore.firestore()
    
    /// Agrega (o reemplaza) un Recipe en la colección "recipes"
    func addRecipe(_ recipe: Recipe) throws {
        try db.collection("recipes")
            .document(recipe.id)
            .setData(from: recipe)
    }
    
    func fetchRecipes() async -> [Recipe] {
            do {
                let snapshot = try await db.collection("recipes").getDocuments()
                
                let fetchedRecipes: [Recipe] = snapshot.documents.compactMap { doc in
                    try? doc.data(as: Recipe.self)
                }
                
                return fetchedRecipes
            } catch {
                print("Error al obtener las recetas: \(error)")
                return []
            }
        }
}
