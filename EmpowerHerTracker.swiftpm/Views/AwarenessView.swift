//
//  AwarenessView.swift
//  EmpowerHerTracker
//
//  Created by Soumyadeep Chatterjee on 2/3/25.
//

import SwiftUI

struct AwarenessView: View {
    
    let facts = [
        "Women in Saudi Arabia gained the right to vote in 2015.",
        "The Equal Pay Act of 1983 aimed to abolish wage disparity based on gender.",
        "Malala Yosafzai, a Nobel Laureate, advocates for girls education worldwide."
    ]
    
    @State private var currentIndex = 0
    
    var body: some View {
        VStack {
            Text("Did you know?")
                .font(.title)
                .padding()
            
            Text(facts[currentIndex])
                .font(.headline)
                .padding()
                .frame(width: 300, height: 150)
                .background(Color.purple.opacity(0.2))
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding()
            
            HStack {
                Button(action: previousFact) { Text("Previous") }
                Spacer()
                Button(action: nextFact) { Text("Next") }
            }
            .padding()
        }
    }
    
    func previousFact() {
        if currentIndex > 0 { currentIndex -= 1}
    }
    
    func nextFact() {
        if currentIndex < facts.count - 1 {currentIndex += 1}
    }
}
