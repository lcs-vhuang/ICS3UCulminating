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
    var grid: [[SudokuCell]]
    let solution: [[Int]]
    
    // MARK: Initializers
    init(initialValues: [[Int?]], solution: [[Int]]) {
        var newGrid: [[SudokuCell]] = []
        for row in 0..<9 {
            var currentRow: [SudokuCell] = []
            for column in 0..<9 {
                let value = initialValues[row][column]
                currentRow.append(SudokuCell(value: value, isGiven: value != nil))
            }
            newGrid.append(currentRow)
        }
        self.grid = newGrid
        self.solution = solution
    }
    
    // MARK: Functions
    func setCellValue(row: Int, column: Int, value: Int?) {
        guard row >= 0 && row < 9 && column >= 0 && column < 9 else { return }
        if !grid[row][column].isGiven {
            grid[row][column].value = value
        }
    }
    
    func isCorrect(row: Int, column: Int) -> Bool {
        guard let value = grid[row][column].value else { return false }
        return value == solution[row][column]
    }
    
    func isSolved() -> Bool {
        for row in 0..<9 {
            for column in 0..<9 {
                if !isCorrect(row: row, column: column) {
                    return false
                }
            }
        }
        return true
    }
}

// MARK: - Difficulty Levels
enum SudokuDifficulty: String, CaseIterable {
    case beginner = "Easy"
    case intermediate = "Medium"
    case advanced = "Hard"
    
    var data: (puzzle: [[Int?]], solution: [[Int]]) {
        switch self {
        case .beginner:
            return (SudokuBoard.easyPuzzle, SudokuBoard.easySolution)
        case .intermediate:
            return (SudokuBoard.mediumPuzzle, SudokuBoard.mediumSolution)
        case .advanced:
            return (SudokuBoard.hardPuzzle, SudokuBoard.hardSolution)
        }
    }
}

// MARK: - Puzzle Data
extension SudokuBoard {
    
    // EASY
    static let easyPuzzle: [[Int?]] = [
        [nil, nil, nil, 2, 6, nil, 7, nil, 1],
        [6, 8, nil, nil, 7, nil, nil, 9, nil],
        [1, 9, nil, nil, nil, 4, 5, nil, nil],
        [8, 2, nil, 1, nil, nil, nil, 4, nil],
        [nil, nil, 4, 6, nil, 2, 9, nil, nil],
        [nil, 5, nil, nil, nil, 3, nil, 2, 8],
        [nil, nil, 9, 3, nil, nil, nil, 7, 4],
        [nil, 4, nil, nil, 5, nil, nil, 3, 6],
        [7, nil, 3, nil, 1, 8, nil, nil, nil]
    ]

    static let easySolution: [[Int]] = [
        [4, 3, 5, 2, 6, 9, 7, 8, 1],
        [6, 8, 2, 5, 7, 1, 4, 9, 3],
        [1, 9, 7, 8, 3, 4, 5, 6, 2],
        [8, 2, 6, 1, 9, 5, 3, 4, 7],
        [3, 7, 4, 6, 8, 2, 9, 1, 5],
        [9, 5, 1, 7, 4, 3, 6, 2, 8],
        [5, 1, 9, 3, 2, 6, 8, 7, 4],
        [2, 4, 8, 9, 5, 7, 1, 3, 6],
        [7, 6, 3, 4, 1, 8, 2, 5, 9]
    ]
    
    // MEDIUM
    static let mediumPuzzle: [[Int?]] = [
        [nil, 2, nil, 6, nil, 8, nil, nil, nil],
        [5, 8, nil, nil, nil, 9, 7, nil, nil],
        [nil, nil, nil, nil, 4, nil, nil, nil, nil],
        [3, 7, nil, nil, nil, nil, 5, nil, nil],
        [6, nil, nil, nil, nil, nil, nil, nil, 4],
        [nil, nil, 8, nil, nil, nil, nil, 1, 3],
        [nil, nil, nil, nil, 2, nil, nil, nil, nil],
        [nil, nil, 9, 8, nil, nil, nil, 3, 6],
        [nil, nil, nil, 3, nil, 6, nil, 9, nil]
    ]

    static let mediumSolution: [[Int]] = [
        [1, 2, 3, 6, 7, 8, 9, 4, 5],
        [5, 8, 4, 2, 3, 9, 7, 6, 1],
        [9, 6, 7, 1, 4, 5, 3, 2, 8],
        [3, 7, 2, 4, 6, 1, 5, 8, 9],
        [6, 9, 1, 5, 8, 3, 2, 7, 4],
        [4, 5, 8, 7, 9, 2, 6, 1, 3],
        [8, 3, 6, 9, 2, 4, 1, 5, 7],
        [2, 1, 9, 8, 5, 7, 4, 3, 6],
        [7, 4, 5, 3, 1, 6, 8, 9, 2]
    ]
    
    // HARD
    static let hardPuzzle: [[Int?]] = [
        [8, nil, nil, nil, nil, nil, nil, nil, nil],
        [nil, nil, 3, 6, nil, nil, nil, nil, nil],
        [nil, 7, nil, nil, 9, nil, 2, nil, nil],
        [nil, 5, nil, nil, nil, 7, nil, nil, nil],
        [nil, nil, nil, nil, 4, 5, 7, nil, nil],
        [nil, nil, nil, 1, nil, nil, nil, 3, nil],
        [nil, nil, 1, nil, nil, nil, nil, 6, 8],
        [nil, nil, 8, 5, nil, nil, nil, 1, nil],
        [nil, 9, nil, nil, nil, nil, 4, nil, nil]
    ]

    static let hardSolution: [[Int]] = [
        [8, 1, 2, 7, 5, 3, 6, 4, 9],
        [9, 4, 3, 6, 8, 2, 1, 7, 5],
        [6, 7, 5, 4, 9, 1, 2, 8, 3],
        [1, 5, 4, 2, 3, 7, 8, 9, 6],
        [3, 6, 9, 8, 4, 5, 7, 2, 1],
        [2, 8, 7, 1, 6, 9, 5, 3, 4],
        [5, 2, 1, 9, 7, 4, 3, 6, 8],
        [4, 3, 8, 5, 2, 6, 9, 1, 7],
        [7, 9, 6, 3, 1, 8, 4, 5, 2]
    ]
}
