//
//  Pan.swift
//  Sourdough-bread-calculator
//
//  Created by Pablo Cigoy on 06.01.25.
//


import FirebaseFirestore


struct Pan: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String
}
