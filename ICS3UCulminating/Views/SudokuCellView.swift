//
//  SudokuCellView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026/6/1.
//

import SwiftUI

// VIEW
// SudokuCellView represents a single square in the Sudoku grid.
struct SudokuCellView: View {
    
    // MARK: Stored properties
    
    // The individual cell data from our model
    let cell: SudokuCell
    
    // Whether this specific cell is currently selected by the user
    let isSelected: Bool
    
    // Whether the cell should show an error state
    let isIncorrect: Bool
    
    // MARK: Computed properties
    
    // The main visual body of the cell
    var body: some View {
        ZStack {
            // Background color logic:
            // 1. If it's incorrect, use red.
            // 2. If it's a "given" number, use a light gray background.
            // 3. If it's selected, use a light blue highlight.
            // 4. Otherwise, use plain white.
            Rectangle()
                .fill(isIncorrect ? Color.red.opacity(0.4) : (cell.isGiven ? Color(white: 0.95) : (isSelected ? Color.blue.opacity(0.3) : Color.white)))
                .animation(.easeInOut(duration: 0.2), value: isIncorrect)
                // Add a thin border around every cell
                .border(Color.gray.opacity(0.5), width: 0.5)
            
            // The number display
            Text(cell.displayValue)
                .font(.system(.title2, design: .rounded))
                // Style: "Given" numbers are bold and black, user numbers are blue.
                .fontWeight(cell.isGiven ? .bold : .regular)
                .foregroundStyle(cell.isGiven ? .black : .blue)
        }
        // Ensure the cell is a perfect square
        .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    VStack {
        // Previewing different cell states
        SudokuCellView(cell: SudokuCell(value: 5, isGiven: true), isSelected: false, isIncorrect: false)
            .frame(width: 60)
        SudokuCellView(cell: SudokuCell(value: 3, isGiven: false), isSelected: true, isIncorrect: false)
            .frame(width: 60)
        SudokuCellView(cell: SudokuCell(value: nil, isGiven: false), isSelected: false, isIncorrect: false)
            .frame(width: 60)
        SudokuCellView(cell: SudokuCell(value: 4, isGiven: false), isSelected: false, isIncorrect: true)
            .frame(width: 60)
    }
}
