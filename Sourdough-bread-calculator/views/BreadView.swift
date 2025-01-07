//
//  BreadView.swift
//  Sourdough-bread-calculator
//
//  Created by Pablo Cigoy on 07.01.25.
//

import SwiftUI

struct BreadView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Bread Section")
                    .font(.title)
                    .foregroundColor(.black)
                
            
                // Botón / NavigationLink para ir a AddBreadView
                               NavigationLink(destination: AddBreadView()) {
                                   Text("Add New Bread")
                                       .font(.headline)
                                       .padding()
                                       .foregroundColor(.white)
                                       .background(Color.blue)
                                       .cornerRadius(8)
                               }
                               
                               Spacer()
                           }
                           .padding()
                           .background(Color.white)
                           .navigationTitle("Bread")
                       }
    }
}




