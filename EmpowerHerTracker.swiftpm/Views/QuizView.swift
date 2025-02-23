//
//  QuizView.swift
//  EmpowerHerTracker
//
//  Created by Soumyadeep Chatterjee on 2/3/25.
//

import SwiftUI

struct QuizView: View {
    let questions = [
        ("Which year was the Equal Pay Act passed?", ["1963", "1980", "1995"], 0),
        ("Who is a famous advocate for girls' education?", ["Malala Yousafzai", "Oprah Winfrey", "Serena Williams"], 0),
        ("Which country was the first to grant women the right to vote?",["New Zealand", "USA", "UK"],0)
    ]
    
    @State private var currentQuestion = 0
    @State private var score = 0
    @State private var showQuizEnd = false
    @State private var selectedAnswerIndex: Int? = nil
    @State private var isCorrect: Bool? = nil
    
    var body: some View {
        VStack {
            if showQuizEnd {
                VStack {
                    Text("Quiz Complete!")
                        .font(.title)
                        .padding()
                    Text("Your final score: \(score)/\(questions.count)")
                        .font(.headline)
                        .padding()
                    Button(action: restartQuiz){
                        Text("Restart Quiz")
                            .frame(width: 200, height: 50)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            } else {
                Text(questions[currentQuestion].0)
                    .font(.headline)
                    .padding()
                ForEach(0 ..< questions[currentQuestion].1.count, id:\.self) { index in
                    Button(action: {
                        checkAnswer(index)
                        selectedAnswerIndex = index
                        isCorrect = index == questions[currentQuestion].2
                    }) {
                        Text(questions[currentQuestion].1[index])
                            .frame(width: 250, height: 50)
                            .background(selectedAnswerIndex == index ?
                                (isCorrect == true ? Color.green : Color.red) : Color.blue
                            )
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .animation(.easeInOut, value: selectedAnswerIndex)
                }
                
                Text("Score: \(score)")
                    .font(.headline)
                    .padding()
                    .foregroundColor(score > questions.count / 2 ? .green : .red)
                    .overlay(Text(score > questions.count / 2 ? "Great job!" : "Keep going!").font(.caption).padding(.top, 30))
            }
        }
        
    }
    
    func checkAnswer(_ index: Int) {
//        if index == questions[currentQuestion].2 {
//            score += 1
//        }
//        if currentQuestion < questions.count - 1 {
//            currentQuestion += 1
//        } else {
//            showQuizEnd = true
//        }
        
        if selectedAnswerIndex == nil {
            if index == questions[currentQuestion].2 {
                score += 1
            }
            selectedAnswerIndex = index
            isCorrect = index == questions[currentQuestion].2
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if currentQuestion < questions.count - 1 {
                    currentQuestion += 1
                    selectedAnswerIndex = nil
                    isCorrect = nil
                } else {
                    showQuizEnd = true
                }
            }
        }
    }
    
    
    func restartQuiz() {
        currentQuestion = 0
        score = 0
        showQuizEnd = false
        selectedAnswerIndex = nil
    }
}
