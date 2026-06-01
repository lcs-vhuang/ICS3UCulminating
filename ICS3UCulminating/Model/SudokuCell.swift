//
//  SudokuCell.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026/6/1.
//

import Foundation

// MODEL
struct SudokuCell: Identifiable {
    
    // MARK: Stored properties
    
    // Unique identifier to conform to Identifiable protocol
    let id = UUID()
    
    // The value of the cell (1-9), or nil if empty
    var value: Int?
    
    // Whether this cell was part of the original puzzle and cannot be changed
    let isGiven: Bool
    
    // MARK: Computed properties
    
    // A string representation of the value for display
    var displayValue: String {
        if let value = value {
            return String(value)
        } else {
            return ""
        }
    }
}
