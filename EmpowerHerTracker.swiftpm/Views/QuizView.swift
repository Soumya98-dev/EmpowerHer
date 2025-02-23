//
//  QuizView.swift
//  EmpowerHerTracker
//
//  Created by Soumyadeep Chatterjee on 2/3/25.
//

import SwiftUI

struct QuizView: View {    
    let quizQuestions: [(String, [String], Int)]
    
    @State private var currentQuestion = 0
    @State private var score = 0
    @State private var showQuizEnd = false
    @State private var selectedAnswerIndex: Int? = nil
    @State private var isCorrect: Bool? = nil
    @State private var pastScores: [Int] = []
    @State private var lastScore: Int = 0
    
    let userDefaultsKey = "QuizScores"
    let lastScoreKey = "LastQuizScore"
    
    var body: some View {
        VStack {
            if showQuizEnd {
                VStack {
                    Text("Quiz Complete!")
                        .font(.title)
                        .padding()
                    Text("Your final score: \(score)/\(quizQuestions.count)")
                        .font(.headline)
                        .padding()
                    Text("Last Score: \(lastScore)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Button(action: restartQuiz){
                        Text("Restart Quiz")
                            .frame(width: 200, height: 50)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            } else {
                Text(quizQuestions[currentQuestion].0)
                    .font(.headline)
                    .padding()
                ForEach(0 ..< quizQuestions[currentQuestion].1.count, id:\.self) { index in
                    Button(action: {
                        checkAnswer(index)
                        selectedAnswerIndex = index
                        isCorrect = index == quizQuestions[currentQuestion].2
                    }) {
                        Text(quizQuestions[currentQuestion].1[index])
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
                    .foregroundColor(score > quizQuestions.count / 2 ? .green : .red)
                    .overlay(Text(score > quizQuestions.count / 2 ? "Great job!" : "Keep going!").font(.caption).padding(.top, 30))
            }
        }
        .onAppear{
            loadLastScore()
        }
    }
    
    func checkAnswer(_ index: Int) {
        if selectedAnswerIndex == nil {
            if index == quizQuestions[currentQuestion].2 {
                score += 1
            }
            selectedAnswerIndex = index
            isCorrect = index == quizQuestions[currentQuestion].2
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if currentQuestion < quizQuestions.count - 1 {
                    currentQuestion += 1
                    selectedAnswerIndex = nil
                    isCorrect = nil
                } else {
                    saveScore()
                    showQuizEnd = true
                    
                    DispatchQueue.main.async {
                        loadLastScore()
                    }
                }
            }
        }
    }
    
    func saveScore() {
        var scores = loadPastScores()
        scores.append(score)
        
        if let encoded = try? JSONEncoder().encode(scores) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
        
        UserDefaults.standard.set(score, forKey: lastScoreKey)
    }
    
    func loadLastScore() {
        lastScore = UserDefaults.standard.integer(forKey: lastScoreKey)
    }
    
    func loadPastScores() -> [Int] {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedScores = try? JSONDecoder().decode([Int].self, from:savedData) {
            return decodedScores
        }
        return []
    }
    
    func restartQuiz() {
        currentQuestion = 0
        score = 0
        showQuizEnd = false
        selectedAnswerIndex = nil
    }
}
