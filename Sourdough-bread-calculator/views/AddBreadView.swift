//
//  AddBreadView.swift
//  Sourdough-bread-calculator
//
//  Created by Pablo Cigoy on 07.01.25.
//
import SwiftUI

struct AddBreadView: View {
    // MARK: - ViewModel para guardar la receta
    @StateObject private var viewModel = RecipesViewModel()

    // MARK: - Campos del Recipe
    @State private var id: String = UUID().uuidString
    @State private var name: String = ""
    @State private var breadsPerRecipe: Int = 10
    @State private var description: String = ""
    @State private var timeInMinutes: Int? = nil
    @State private var hasAutolysis: Bool = false

    /// Lista de ingredientes que se irá rellenando dinámicamente
    @State private var ingredientList: [Ingredient] = []

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                // MARK: - Sección de info básica
                Section(header: Text("Basic Info")) {
                    TextField("ID (auto)", text: $id)
                        .disabled(true)  // ID autogenerado por UUID

                    TextField("Name of the Bread", text: $name)

                    Stepper("Breads per Recipe: \(breadsPerRecipe)",
                            value: $breadsPerRecipe,
                            in: 1...1000)

                    Toggle("Has Autolysis?", isOn: $hasAutolysis)
                }

                // MARK: - Sección de descripción
                Section(header: Text("Description")) {
                    TextField("Short description", text: $description)
                    // O, si prefieres multiline:
                    // TextEditor(text: $description)
                    //    .frame(minHeight: 80)
                }

                // MARK: - Sección de tiempo (opcional)
                Section(header: Text("Time in Minutes (optional)")) {
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
                }

                // MARK: - Sección de ingredientes
                Section(header: Text("Ingredients")) {
                    // Lista editable de ingredientes
                    ForEach($ingredientList, id: \.id) { $ingredient in
                        VStack(alignment: .leading) {
                            TextField("Name", text: $ingredient.name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())

                            HStack() {
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
                        // Permite eliminar ingredientes
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

                // MARK: - Botón para guardar la receta
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
        // Convertir el array de ingredientes a diccionario [id: Ingredient]
        let finalIngredientsDict = Dictionary(
            uniqueKeysWithValues: ingredientList.map { ($0.id, $0) }
        )

        // Construimos la receta con los campos ingresados
        let newRecipe = Recipe(
            id: id,
            name: name,
            breadsPerRecipe: breadsPerRecipe,
            description: description,
            ingredients: finalIngredientsDict,
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
