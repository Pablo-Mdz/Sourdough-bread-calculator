//
//  AddBreadView.swift
//  Sourdough-bread-calculator
//
//  Created by Pablo Cigoy on 07.01.25.
//
import SwiftUI

struct AddBreadView: View {
    @StateObject private var viewModel = RecipesViewModel()

    // MARK: - Campos del Recipe
    @State private var id: String = UUID().uuidString
    @State private var name: String = ""
    @State private var breadsPerRecipe: Int = 10
    @State private var description: String = ""
    
    @State private var hasAutolysis: Bool = false
    @State private var timeInMinutes: Int? = nil
    
    /// Lista de ingredientes que se irá rellenando dinámicamente
    @State private var ingredientList: [Ingredient] = []

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                // MARK: - Sección de información básica
                Section(header: Text("Bread Info")) {
                    TextField("Name of the Bread", text: $name)
                    
                    Stepper("Breads per Recipe: \(breadsPerRecipe)",
                            value: $breadsPerRecipe,
                            in: 1...1000)
                    
                    Toggle("Has Autolysis?", isOn: $hasAutolysis)
                }
             
                
                // MARK: - Sección de autólisis (solo si hasAutolysis = true)
                if hasAutolysis {
                    Section(header: Text("Autolysis Time")) {
                        Stepper(
                            label: {
                                if let time = timeInMinutes {
                                    Text("Time: \(time) min")
                                } else {
                                    Text("No time set")
                                }
                            },
                            onIncrement: { incrementTime() },
                            onDecrement: { decrementTime() }
                        )
                        
                        Button("Clear Time") {
                            timeInMinutes = nil
                        }
                        .foregroundColor(.red)
                        
                        // Texto sobre pliegues
                        Text("You can do 3 folds every 40 minutes approximately.")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
                
                // MARK: - Sección de descripción
                Section(header: Text("Description")) {
                    TextField("Short description", text: $description)
                }
                // MARK: - Sección de ingredientes
                Section(header: Text("Ingredients")) {
                    ForEach($ingredientList, id: \.id) { $ingredient in
                        VStack(alignment: .leading) {
                            TextField("Ingredient Name", text: $ingredient.name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())

                            HStack {
                                TextField("Amount (base)", value: $ingredient.amount, format: .number)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .keyboardType(.decimalPad)
                                
                                TextField("Unit (e.g. g, ml, etc.)", text: $ingredient.unit)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                        }
                        .padding(.vertical, 5)
                    }
                    .onDelete { indexSet in
                        ingredientList.remove(atOffsets: indexSet)
                    }

                    Button(action: {
                        let newIngredient = Ingredient(
                            id: UUID().uuidString,
                            name: "",
                            amount: 0.0,
                            unit: "",
                            standardAmounts: [:]
                        )
                        ingredientList.append(newIngredient)
                    }) {
                        Label("Add Ingredient", systemImage: "plus")
                    }
                }

                // MARK: - Sección de guardado
                Section {
                    Button(action: {
                        saveRecipe()
                    }) {
                        Text("Save Bread")
                            .foregroundColor(.blue)
                        
                    }
                }
            }
            .navigationTitle("Add New Bread")
        }
    }

    // MARK: - Funciones Auxiliares
    private func incrementTime() {
        if timeInMinutes == nil {
            timeInMinutes = 0
        }
        timeInMinutes? += 5
    }

    private func decrementTime() {
        if timeInMinutes == nil {
            timeInMinutes = 0
        }
        if let currentTime = timeInMinutes, currentTime > 0 {
            timeInMinutes = currentTime - 5
        }
    }

    private func saveRecipe() {
       

        // Construimos la receta con los campos ingresados
        let newRecipe = Recipe(
            id: id,
            name: name,
            breadsPerRecipe: breadsPerRecipe,
            description: description,
            ingredients: ingredientList,
            timeInMinutes: timeInMinutes,
            hasAutolysis: hasAutolysis
        )

        // Guardamos en Firestore mediante el ViewModel
        viewModel.addRecipe(newRecipe)

        print("New Recipe created: \(newRecipe)")

        // Cerrar la vista
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    AddBreadView()
}
