//
//  TrackerView.swift
//  EmpowerHerTracker
//
//  Created by Soumyadeep Chatterjee on 2/3/25.
//

import SwiftUI


struct PeriodLog: Codable, Identifiable {
    let id: UUID
    let start: String
    let end: String
    let recorded: String
    let predictedNextPeriod: String
}

struct TrackerView: View {
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var cycleLength = 28
    @State private var nextPeriodDate: String = "Not Predicted Yet"
    @State private var periodLogs: [PeriodLog] = []
    
    let userDefaultsKey = "PeriodLogs"
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Log Your Period")
                    .font(.title)
                    .padding()
                
                DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                    .padding()
                
                DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                    .padding()
                
                Button(action: logPeriod) {
                    Text("Save Period Logs")
                        .frame(width: 200, height: 50)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.pink, Color.red]), startPoint: .leading, endPoint: .trailing))
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .font(.headline)
                        .padding()
                }
                
                Text("Next Period: \(nextPeriodDate)")
                    .font(.headline)
                    .padding()
                
                Divider()
                
                Text("Previous Logs")
                    .font(.title2)
                    .padding(.top)
                
                ForEach(periodLogs) { log in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Start: \(log.start)")
                                .font(.headline)
                            Text("End: \(log.end)")
                            Text("Recorded On: \(log.recorded)")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("Predicted Next Period: \(log.predictedNextPeriod)")
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                        Spacer()
                        Button(action: {deleteLog(log) }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                                .padding()
                                .background(Circle().fill(Color.white).shadow(radius: 2))
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color.white).shadow(radius: 3))
                    .padding(.horizontal)
                }
            }
            .padding()
        }
        .onAppear(perform: loadLogs)
    }
    
    func logPeriod() {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        
        let nextStart = Calendar.current.date(byAdding: .day, value: cycleLength, to: startDate) ?? Date()
        let predictedNextPeriod = formatter.string(from: nextStart)
        nextPeriodDate = predictedNextPeriod
        
        let newLog = PeriodLog(
            id: UUID(),
            start: formatter.string(from: startDate),
            end: formatter.string(from: endDate),
            recorded: formatter.string(from: Date()),
            predictedNextPeriod: predictedNextPeriod
        )
        
        var savedLogs = loadSavedLogs()
        savedLogs.append(newLog)
        
        if let encoded = try? JSONEncoder().encode(savedLogs) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
        
        withAnimation {
            periodLogs = savedLogs
        }
    }
    
    func deleteLog(_ log: PeriodLog) {
        periodLogs.removeAll {$0.id == log.id}
        
        if let encoded = try? JSONEncoder().encode(periodLogs) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    func loadLogs() {
        periodLogs = loadSavedLogs()
    }
    
    func loadSavedLogs() -> [PeriodLog] {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedLogs = try? JSONDecoder().decode([PeriodLog].self, from: savedData) {
            return decodedLogs
        }
        
        return []
    }
    
    func predictNextPeriod() -> String {
        let nextStart = Calendar.current.date(byAdding: .day, value: cycleLength, to: startDate) ?? Date()
        print("Next period starts on: \(nextStart.formatted(date: .long, time: .omitted))")
        nextPeriodDate = nextStart.formatted(date: .long, time: .omitted)
        return nextPeriodDate
    }
}
