//
//  QuizUtils.swift
//  EmpowerHerTracker
//
//  Created by Soumyadeep Chatterjee on 2/23/25.
//

import Foundation

func generateQuizFromFacts(facts: [String]) -> [(String, [String], Int)] {
    var quizQuestions: [(String, [String], Int)] = []
    
    for fact in facts {
        var questionText = fact
        var correctAnswer = ""
        var wrongAnswers: [String] = []
        
        let words = fact.components(separatedBy: " ")

        if let number = words.first(where: {Int($0) != nil}) {
            correctAnswer = number
            if correctAnswer.count == 4 {
                wrongAnswers = ["1960", "1985", "2000", "1995"].filter { $0 != correctAnswer }
            } else if Int(correctAnswer) ?? 0 <= 12 {
                wrongAnswers = ["1", "5", "10", "12"].filter{ $0 != correctAnswer}
            }
            else {
                wrongAnswers = ["75", "90", "70", "60"].filter{ $0 != correctAnswer}
            }
            questionText = fact.replacingOccurrences(of: number, with: "______")
        }
        
        else if let country = words.first(where: { ["Switzerland", "USA", "New Zealand", "Saudi Arabia", "Iceland"].contains($0) }) {
            correctAnswer = country
            wrongAnswers = ["India", "Germany", "France", "Brazil"].filter { $0 != correctAnswer }
            questionText = fact.replacingOccurrences(of: country, with: "______")
        }
        
        else if let keyConcept = words.first(where: { ["right", "vote", "law", "education", "president"].contains($0.lowercased()) }) {
            correctAnswer = keyConcept
            wrongAnswers = ["Freedom", "Justice", "Policy", "None"].filter { $0 != correctAnswer }
            questionText = fact.replacingOccurrences(of: keyConcept, with: "______")
        }

        if !correctAnswer.isEmpty {
            let choices = ([correctAnswer] + wrongAnswers).shuffled()
            let correctIndex = choices.firstIndex(of: correctAnswer) ?? 0
            quizQuestions.append((questionText, choices, correctIndex))
        }
    }
    
    return quizQuestions
}
