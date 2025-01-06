//
//  PanViewModel.swift
//  Sourdough-bread-calculator
//
//  Created by Pablo Cigoy on 06.01.25.
//


import SwiftUI
import Firebase

class PanViewModel: ObservableObject {
    @Published var pans: [Pan] = []
    private let db = Firestore.firestore()

    init() {
        // Cargar la lista al iniciar el ViewModel.
        fetchPans()
    }
    
    func fetchPans() {
        db.collection("pans").addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error al obtener los panes: \(error)")
                return
            }
            guard let documents = querySnapshot?.documents else {
                print("No hay documentos en la colección 'pans'")
                return
            }
            self.pans = documents.compactMap { doc in
                try? doc.data(as: Pan.self)
            }
        }
    }
    
    func addPan(name: String) {
        let newPan = Pan(name: name)
        do {
            // Creamos un nuevo documento en "pans"
            _ = try db.collection("pans").addDocument(from: newPan)
        } catch {
            print("Error al guardar el pan: \(error)")
        }
    }
}