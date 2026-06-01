//
//  SudokuCell.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026/6/1.
//

import Foundation

// MODEL
// SudokuCell represents a single square in the 9x9 Sudoku grid.
// It conforms to Identifiable so it can be easily used in SwiftUI lists and loops.
struct SudokuCell: Identifiable {
    
    // MARK: Stored properties
    
    // A unique ID generated for each cell instance to satisfy the Identifiable protocol requirements.
    let id = UUID()
    
    // The current number in the cell. 
    // It's optional (Int?) because the cell can be empty (nil).
    // Valid values are 1 through 9.
    var value: Int?
    
    // A constant flag that tells us if this number was provided by the game at the start.
    // If true, the player should not be allowed to change this cell's value.
    let isGiven: Bool
    
    // MARK: Computed properties
    
    // A helper property that returns the value as a String for UI display.
    // If the value is nil, it returns an empty string so nothing shows up in the grid.
    var displayValue: String {
        if let value = value {
            return String(value)
        } else {
            return ""
        }
    }
}
