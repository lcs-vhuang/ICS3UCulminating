//
//  SudokuView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026/6/1.
//

import SwiftUI

// VIEW
// SudokuView is the main screen for our game.
struct SudokuView: View {
    
    // MARK: Stored properties
    
    // We create an instance of our ViewModel.
    // Because it's @Observable, this view will update automatically when the ViewModel changes.
    @State var viewModel = SudokuViewModel()
    
    // MARK: Computed properties
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                // 1. The Sudoku Grid
                // To show the 3x3 boxes clearly, we use a "Grid of Grids" approach.
                // The outer Grid handles the nine 3x3 boxes.
                Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                    ForEach(0..<3, id: \.self) { boxRow in
                        GridRow {
                            ForEach(0..<3, id: \.self) { boxColumn in
                                
                                // Each of these is one 3x3 subgrid (box)
                                Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                                    ForEach(0..<3, id: \.self) { localRow in
                                        GridRow {
                                            ForEach(0..<3, id: \.self) { localColumn in
                                                
                                                // Calculate the actual row and column index in the 9x9 board
                                                let rowIndex = boxRow * 3 + localRow
                                                let columnIndex = boxColumn * 3 + localColumn
                                                
                                                // Get the cell data from the ViewModel
                                                let cell = viewModel.board.grid[rowIndex][columnIndex]
                                                
                                                // Check if this cell is currently selected
                                                let isSelected = viewModel.selectedCell?.row == rowIndex && 
                                                               viewModel.selectedCell?.column == columnIndex
                                                
                                                // Create our custom cell view
                                                SudokuCellView(cell: cell, isSelected: isSelected)
                                                    .onTapGesture {
                                                        // Tell the ViewModel to select this cell when tapped
                                                        viewModel.selectCell(row: rowIndex, column: columnIndex)
                                                    }
                                            }
                                        }
                                    }
                                }
                                // Add a thick black border around each 3x3 box.
                                // Because spacing is 0, these borders will touch and create thicker lines.
                                .border(Color.black, width: 1)
                            }
                        }
                    }
                }
                // Thicker outer border for the entire 9x9 board
                .border(Color.black, width: 2)
                .padding()
                
                // 2. Number Entry Controls
                // Buttons 1-9 for the user to enter values into the selected cell.
                HStack {
                    ForEach(1...9, id: \.self) { number in
                        Button {
                            // Tell the ViewModel to enter this number
                            viewModel.enterNumber(number)
                        } label: {
                            Text("\(number)")
                                .font(.title2)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.horizontal)
                
                // 3. Action Buttons (Clear & Reset)
                HStack(spacing: 20) {
                    Button(role: .destructive) {
                        viewModel.clearSelectedCell()
                    } label: {
                        Label("Clear Cell", systemImage: "eraser")
                    }
                    .buttonStyle(.bordered)
                    
                    Button {
                        viewModel.resetGame()
                    } label: {
                        Label("Reset Game", systemImage: "arrow.clockwise")
                    }
                    .buttonStyle(.bordered)
                }
                
                Spacer()
            }
            .navigationTitle("Sudoku")
            // Show an alert when the player wins
            .alert("Congratulations!", isPresented: .constant(viewModel.gameIsWon)) {
                Button("New Game") {
                    viewModel.resetGame()
                }
            } message: {
                Text("You've successfully solved the puzzle!")
            }
        }
    }
}

#Preview {
    SudokuView()
}
