//
//  SudokuBoard.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026/6/1.
//

import Foundation
import Observation

// MODEL
// SudokuBoard manages the state and rules of a 9x9 Sudoku game.
// The @Observable macro allows SwiftUI views to automatically update when properties change.
@Observable
class SudokuBoard {
    
    // MARK: Stored properties
    
    // A 2D array (array of arrays) that holds 81 SudokuCell objects.
    // The outer array represents rows, and the inner arrays represent columns.
    var grid: [[SudokuCell]]
    
    // MARK: Initializers
    
    // This initializer sets up the 9x9 grid.
    // It can take an optional 2D array of integers to populate the board with a specific puzzle.
    init(initialValues: [[Int?]]? = nil) {
        var newGrid: [[SudokuCell]] = []
        
        // Loop through 9 rows
        for row in 0..<9 {
            var currentRow: [SudokuCell] = []
            // Loop through 9 columns for each row
            for column in 0..<9 {
                // Get the value from the initial data if it exists
                let value = initialValues?[row][column]
                
                // Create a new cell. If 'value' is not nil, it's a "given" (pre-filled) cell.
                currentRow.append(SudokuCell(value: value, isGiven: value != nil))
            }
            // Add the completed row to our grid
            newGrid.append(currentRow)
        }
        
        self.grid = newGrid
    }
    
    // MARK: Functions
    
    // Update the value of a specific cell based on its row and column index.
    func setCellValue(row: Int, column: Int, value: Int?) {
        // Safety check: ensure the coordinates are within the 0-8 range.
        guard row >= 0 && row < 9 && column >= 0 && column < 9 else { return }
        
        // Logical check: only allow updating the cell if it wasn't pre-filled by the puzzle.
        if !grid[row][column].isGiven {
            grid[row][column].value = value
        }
    }
    
    // This function checks if placing a specific number at a position follows Sudoku rules.
    func isValid(row: Int, column: Int, value: Int) -> Bool {
        // 1. Check the Row: iterate through all columns in this specific row.
        for i in 0..<9 {
            // If we find the same value in another cell in the same row, it's invalid.
            if i != column && grid[row][i].value == value {
                return false
            }
        }
        
        // 2. Check the Column: iterate through all rows in this specific column.
        for i in 0..<9 {
            // If we find the same value in another cell in the same column, it's invalid.
            if i != row && grid[i][column].value == value {
                return false
            }
        }
        
        // 3. Check the 3x3 Box: 
        // First, find the starting index of the 3x3 box this cell belongs to.
        // For example, if row is 4, (4/3)*3 = 1*3 = 3. The box starts at row 3.
        let boxRowStart = (row / 3) * 3
        let boxColumnStart = (column / 3) * 3
        
        // Loop through the 3 rows and 3 columns of the subgrid box.
        for i in boxRowStart..<boxRowStart + 3 {
            for j in boxColumnStart..<boxColumnStart + 3 {
                // If we find the same value in another cell in the same box, it's invalid.
                if (i != row || j != column) && grid[i][j].value == value {
                    return false
                }
            }
        }
        
        // If we passed all three checks, the placement is valid!
        return true
    }
    
    // Checks the entire board to see if all cells are filled and follow Sudoku rules.
    func isSolved() -> Bool {
        for row in 0..<9 {
            for column in 0..<9 {
                // If any cell is empty, the puzzle isn't solved.
                guard let value = grid[row][column].value else {
                    return false
                }
                
                // If any filled cell violates a rule, the puzzle isn't solved correctly.
                if !isValid(row: row, column: column, value: value) {
                    return false
                }
            }
        }
        // If we checked all 81 cells and found no issues, the player wins!
        return true
    }
}

// MARK: Example Data
extension SudokuBoard {
    // A standard Sudoku puzzle used for testing or demonstration.
    // 'nil' represents an empty square the player must fill.
    static let examplePuzzle: [[Int?]] = [
        [5, 3, nil, nil, 7, nil, nil, nil, nil],
        [6, nil, nil, 1, 9, 5, nil, nil, nil],
        [nil, 9, 8, nil, nil, nil, nil, 6, nil],
        [8, nil, nil, nil, 6, nil, nil, nil, 3],
        [4, nil, nil, 8, nil, 3, nil, nil, 1],
        [7, nil, nil, nil, 2, nil, nil, nil, 6],
        [nil, 6, nil, nil, nil, nil, 2, 8, nil],
        [nil, nil, nil, 4, 1, 9, nil, nil, 5],
        [nil, nil, nil, nil, 8, nil, nil, 7, 9]
    ]
}
