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
        "Malala Yousafzai, a Nobel Laureate, advocates for girls' education worldwide.",
        "The first women’s rights convention was held in 1848 in Seneca Falls, New York.",
        "Marie Curie was the first woman to win a Nobel Prize—and she won twice!",
        "Women in Switzerland gained the right to vote only in 1971.",
        "Iceland was the first country to elect a female president in 1980.",
        "The gender pay gap still exists today, with women earning about 82 cents for every dollar a man earns.",
        "The UN declared March 8 as International Women's Day in 1977.",
        "Simone Biles holds the record for the most gymnastics World Championships medals ever won."
    ]

    
    @State private var currentIndex = 0

    
    var body: some View {
        VStack {
            Text("Did you know?")
                .font(.title)
                .padding()
            
            Text(facts[currentIndex])
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()
                .frame(width: 300, height: 150)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.purple.opacity(0.2))
                        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.purple, lineWidth: 1))
                )
                .shadow(radius: 5)
                .scaleEffect(currentIndex % 2 == 0 ? 1.02 : 1.0)
                .animation(.easeInOut(duration: 0.3), value: currentIndex)
                .padding()
                .id(currentIndex)
            
            HStack {
                Button(action: previousFact) {
                    Text("<- Previous")
                        .foregroundColor(currentIndex == 0 ? .gray : .blue)
                        .fontWeight(.bold)
                }
                .disabled(currentIndex == 0)
                Spacer()
                Button(action: nextFact) {
                    Text("Next ->")
                        .foregroundColor(currentIndex == facts.count - 1 ? .gray:.blue)
                        .fontWeight(.bold)
                }
                .disabled(currentIndex == facts.count - 1)
            }
            .padding(.horizontal, 40)
            .padding(.top, 10)
            
            Button(action: randomFact){
                Text("Surprise Me!")
                    .font(.headline)
                    .padding()
                    .frame(width: 180)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
        }
    }
    
    func randomFact() {
        var newIndex: Int
        repeat {
            newIndex = Int.random(in: 0..<facts.count)
        } while newIndex == currentIndex
                    
        withAnimation(.easeInOut(duration:0.4)) {
            currentIndex = newIndex
        }
    }
    
    func previousFact() {
        if currentIndex > 0 {
            withAnimation(.easeInOut(duration: 0.4)) {
                currentIndex -= 1
            }
            
        }
    }
    
    func nextFact() {
        if currentIndex < facts.count - 1 {
            withAnimation(.easeInOut(duration: 0.4)){
                currentIndex += 1
            }
        }
    }
}
