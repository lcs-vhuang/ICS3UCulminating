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
    
    // We receive the ViewModel from the parent view.
    var viewModel: SudokuViewModel
    
    // Used to navigate back to the home screen
    @Environment(\.dismiss) var dismiss
    
    // State to show the success view
    @State private var showingSuccess = false
    
    // MARK: Computed properties
    
    var body: some View {
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
                                            
                                            // Check if cell is incorrect (only show if submitted)
                                            let isIncorrect = viewModel.hasSubmitted && !viewModel.board.isCorrect(row: rowIndex, column: columnIndex)
                                            
                                            // Create our custom cell view
                                            SudokuCellView(cell: cell, isSelected: isSelected, isIncorrect: isIncorrect)
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
            .padding(.horizontal)
            
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
            VStack(spacing: 15) {
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
                .padding(.horizontal, 80)
                
                // I'm Done Button
                Button {
                    viewModel.submitResult()
                    if viewModel.gameIsWon {
                        showingSuccess = true
                    }
                } label: {
                    Text("I'm done!")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
                .padding(.horizontal, 80)
            }
            
            Spacer()
        }
        .navigationTitle("\(viewModel.difficulty.rawValue) Level")
        .navigationBarTitleDisplayMode(.inline)
        // Show success screen when the player wins and submits
        .fullScreenCover(isPresented: $showingSuccess) {
            SuccessView(difficulty: viewModel.difficulty.rawValue)
                .onDisappear {
                    // When the success view is dismissed, we go back to home
                    dismiss()
                }
        }
    }
}

#Preview {
    NavigationStack {
        SudokuView(viewModel: SudokuViewModel(difficulty: .beginner))
    }
}
