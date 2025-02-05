//
//  DateHelper.swift
//  EmpowerHerTracker
//
//  Created by Soumyadeep Chatterjee on 2/3/25.
//

import Foundation

struct DateHelper {
    static func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
}
