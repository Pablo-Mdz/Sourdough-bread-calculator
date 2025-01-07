//
//  ProfileView.swift
//  Sourdough-bread-calculator
//
//  Created by Pablo Cigoy on 07.01.25.
//
import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Profile Section")
                    .font(.title)
                    .foregroundColor(.black)
                
                // Aquí la información de perfil
                
                Spacer()
            }
            .padding()
            .background(Color.white)
            .navigationTitle("Profile")
        }
    }
}
