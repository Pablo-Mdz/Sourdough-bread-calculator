//
//  AddBreadView.swift
//  Sourdough-bread-calculator
//
//  Created by Pablo Cigoy on 07.01.25.
//


import SwiftUI

struct AddBreadView: View {
    // MARK: - Campos del Recipe
    @State private var id: String = UUID().uuidString
    @State private var name: String = ""
    @State private var standardQuantity: Int = 10
    @State private var availableQuantities: String = "10, 11, 12"
    @State private var hasAutolysis: Bool = false
    @StateObject private var viewModel = RecipesViewModel()
    // Steps podrían ser más complejos; de momento, podríamos iniciar con un ejemplo vacío
    // o permitir ingresar un "step_principal" de manera muy simple.
    @State private var steps: [String: Step] = [
        "step_principal" : Step(
            id: "step_principal",
            name: "Masa Principal",
            order: 1,
            ingredients: [:],
            timeInMinutes: nil
        )
    ]
    
    // Ejemplo: si quieres manejar la lógica de guardado en un ViewModel o con un servicio
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            Section(header: Text("Basic Info")) {
                TextField("ID", text: $id)
                    .disabled(true) // Si quieres que se genere automáticamente
                
                TextField("Name", text: $name)
                
                Stepper("Standard Quantity: \(standardQuantity)", value: $standardQuantity, in: 1...1000)
                
                TextField("Available Quantities (separate by commas)", text: $availableQuantities)
                
                Toggle("Has Autolysis?", isOn: $hasAutolysis)
            }
            
            Section(header: Text("Steps (basic)")) {
                // Ejemplo: muestro un único step, "step_principal"
                // El Step en sí podría tener su propio mini-form; si quieres algo más elaborado,
                // podrías hacer un NavigationLink a un subformulario de Steps
                Text("Step ID: \(steps["step_principal"]?.id ?? "")")
                Text("Name: \(steps["step_principal"]?.name ?? "")")
                Stepper(
                    "Order: \(steps["step_principal"]?.order ?? 1)",
                    value: bindingForStepOrder(key: "step_principal"),
                    in: 1...10
                )
                
                Toggle("Time in minutes (30)", isOn: isTimeSet(key: "step_principal"))
                    .onChange(of: isTimeSet(key: "step_principal").wrappedValue) { newValue in
                        if newValue {
                            steps["step_principal"]?.timeInMinutes = 30
                        } else {
                            steps["step_principal"]?.timeInMinutes = nil
                        }
                    }
            }
            
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

// MARK: - Helpers
extension AddBreadView {
    // Para poder modificar un Step específico (por su key) a través de Stepper o toggles.
    private func bindingForStepOrder(key: String) -> Binding<Int> {
        Binding<Int>(
            get: {
                steps[key]?.order ?? 1
            },
            set: { newValue in
                steps[key]?.order = newValue
            }
        )
    }
    
    private func isTimeSet(key: String) -> Binding<Bool> {
        Binding<Bool>(
            get: {
                steps[key]?.timeInMinutes != nil
            },
            set: { newValue in
                if newValue {
                    steps[key]?.timeInMinutes = 30
                } else {
                    steps[key]?.timeInMinutes = nil
                }
            }
        )
    }
    
    private func saveRecipe() {
        // Convertir la cadena de "10, 11, 12" a [Int]
        let quantities = availableQuantities
            .split(separator: ",")
            .compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }
        
        // Crear una instancia de Recipe
        let newRecipe = Recipe(
            id: id,
            name: name,
            standardQuantity: standardQuantity,
            availableQuantities: quantities,
            hasAutolysis: hasAutolysis,
            steps: steps
        )
        
        // TODO: Llamar a tu servicio o ViewModel para subirlo a Firestore.
        // Ejemplo:
         viewModel.addRecipe(newRecipe) 
        
        print("New Recipe: \(newRecipe)")
        
        // Cerrar la vista
        presentationMode.wrappedValue.dismiss()
    }
}
