//
//  SudokuViewModel.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026/6/1.
//

import Foundation
import Observation

// VIEW MODEL
// SudokuViewModel acts as the "brain" for the Sudoku view.
// It manages the board state, handles user interactions, and provides data for the UI.
@Observable
class SudokuViewModel {
    
    // MARK: Stored properties
    
    // The underlying board model that holds the game data.
    // private(set) means other parts of the app can see the board, but only this ViewModel can replace it.
    private(set) var board: SudokuBoard
    
    let difficulty: SudokuDifficulty
    // Keeps track of which cell is currently selected by the user.
    // Holds a tuple containing (row, column). If nil, no cell is selected.
    var selectedCell: (row: Int, column: Int)?
    
    // MARK: Computed properties
    
    // Tells the UI whether the puzzle has been successfully completed.
    var gameIsWon: Bool {
        return board.isSolved()
    }
    
    // MARK: Initializers
    
    // Initializes the ViewModel with a specific puzzle.
    // Defaults to the example puzzle provided in the SudokuBoard class.
    init(difficulty: SudokuDifficulty = .beginner) {

        self.difficulty = difficulty
        
        let data = difficulty.data

        self.board = SudokuBoard(
            initialValues: data.puzzle,
            solution: data.solution
        )
    }
    
    // MARK: Functions
    
    // Called when a user taps on a cell in the grid.
    func selectCell(row: Int, column: Int) {
        // We only allow selection of cells that aren't "given" (pre-filled).
        // This prevents the user from thinking they can change a permanent number.
        if !board.grid[row][column].isGiven {
            selectedCell = (row, column)
        } else {
            // If they tap a given cell, we deselect any currently selected cell.
            selectedCell = nil
        }
    }
    
    // Called when the user chooses a number to place in the selected cell.
    func enterNumber(_ number: Int) {
        // Check if a cell is currently selected.
        if let selection = selectedCell {
            // Update the board at the selected position.
            board.setCellValue(row: selection.row, column: selection.column, value: number)
        }
    }
    
    // Clears the value of the currently selected cell.
    func clearSelectedCell() {
        if let selection = selectedCell {
            board.setCellValue(row: selection.row, column: selection.column, value: nil)
        }
    }
    
    // Resets the board back to its original starting state.
    func resetGame() {

        let data = difficulty.data

        self.board = SudokuBoard(
            initialValues: data.puzzle,
            solution: data.solution
        )

        self.selectedCell = nil
    }
}
