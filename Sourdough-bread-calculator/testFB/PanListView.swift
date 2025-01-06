//
//  PanListView.swift
//  Sourdough-bread-calculator
//
//  Created by Pablo Cigoy on 06.01.25.
//


import SwiftUI

struct PanListView: View {
    // Instanciamos el ViewModel
    @StateObject private var panVM = PanViewModel()
    
    // Texto que escribe el usuario para el nuevo “Pan”
    @State private var newPanName: String = ""

    var body: some View {
        NavigationView {
            VStack {
                // Campo de texto para el nombre
                TextField("Nombre del Pan", text: $newPanName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                // Botón para crear el Pan
                Button("Crear Pan") {
                    panVM.addPan(name: newPanName)
                    // Limpiar el campo de texto
                    newPanName = ""
                }
                .padding()

                // Lista de panes
                List(panVM.pans) { pan in
                    Text(pan.name)
                }.onAppear()
            }
            .navigationTitle("Panes de Prueba")
        }
    }
}

#Preview {
    PanListView()
}

