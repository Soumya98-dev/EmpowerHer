//
//  AwarenessView.swift
//  EmpowerHerTracker
//
//  Created by Soumyadeep Chatterjee on 2/3/25.
//

import SwiftUI

struct AwarenessView: View {
    let facts: [String]

    
    @State private var currentIndex = 0
    @State private var showQuiz = false
    
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
            
            NavigationLink(destination: QuizView(quizQuestions: generateQuizFromFacts(facts: facts))) {
                Text("Test your knowledge")
                    .font(.headline)
                    .padding()
                    .frame(width: 200)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
            .padding(.top, 20)
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
