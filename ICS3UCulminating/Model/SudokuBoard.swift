//
//  SudokuBoard.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026/6/1.
//

import Foundation
import Observation

// MODEL
@Observable
class SudokuBoard {
    
    // MARK: Stored properties
    
    // The 9x9 grid of cells
    var grid: [[SudokuCell]]
    
    // MARK: Initializers
    
    // Initialize with an empty grid or a provided puzzle
    init(initialValues: [[Int?]]? = nil) {
        var newGrid: [[SudokuCell]] = []
        
        for row in 0..<9 {
            var currentRow: [SudokuCell] = []
            for column in 0..<9 {
                let value = initialValues?[row][column]
                currentRow.append(SudokuCell(value: value, isGiven: value != nil))
            }
            newGrid.append(currentRow)
        }
        
        self.grid = newGrid
    }
    
    // MARK: Functions
    
    // Sets the value of a cell if it's not a given cell
    func setCellValue(row: Int, column: Int, value: Int?) {
        guard row >= 0 && row < 9 && column >= 0 && column < 9 else { return }
        
        // Only allow changes to cells that weren't pre-filled
        if !grid[row][column].isGiven {
            grid[row][column].value = value
        }
    }
    
    // Checks if a value is valid at a specific position according to Sudoku rules
    func isValid(row: Int, column: Int, value: Int) -> Bool {
        // Check row
        for i in 0..<9 {
            if i != column && grid[row][i].value == value {
                return false
            }
        }
        
        // Check column
        for i in 0..<9 {
            if i != row && grid[i][column].value == value {
                return false
            }
        }
        
        // Check 3x3 box
        let boxRowStart = (row / 3) * 3
        let boxColumnStart = (column / 3) * 3
        
        for i in boxRowStart..<boxRowStart + 3 {
            for j in boxColumnStart..<boxColumnStart + 3 {
                if (i != row || j != column) && grid[i][j].value == value {
                    return false
                }
            }
        }
        
        return true
    }
    
    // Checks if the entire board is solved correctly
    func isSolved() -> Bool {
        for row in 0..<9 {
            for column in 0..<9 {
                guard let value = grid[row][column].value else {
                    return false // Empty cell
                }
                
                if !isValid(row: row, column: column, value: value) {
                    return false // Rule violation
                }
            }
        }
        return true
    }
}

// MARK: Example Data
extension SudokuBoard {
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
