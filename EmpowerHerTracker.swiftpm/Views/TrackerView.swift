//
//  TrackerView.swift
//  EmpowerHerTracker
//
//  Created by Soumyadeep Chatterjee on 2/3/25.
//

import SwiftUI

struct TrackerView: View {
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var cycleLength = 28
    @State private var nextPeriodDate: String = "Not Predicted Yet"
    
    var body: some View {
        VStack {
            Text("Log Your Period")
                .font(.title)
                .padding()
            
            DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                .padding()
            
            DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                .padding()
            
            Button(action: predictNextPeriod) {
                Text("Predict Next Period")
                    .buttonStyle()
            }
        }
    }
    
    func predictNextPeriod() {
        let nextStart = Calendar.current.date(byAdding: .day, value: cycleLength, to: startDate) ?? Date()
        print("Next period starts on: \(nextStart.formatted(date: .long, time: .omitted))")
    }
}
