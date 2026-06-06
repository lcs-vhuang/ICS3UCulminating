//
//  SudokuDifficulty.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026/6/6.
//

import Foundation

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
