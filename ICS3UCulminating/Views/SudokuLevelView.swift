//
//  SudokuLevelView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026/6/1.
//

import SwiftUI

// VIEW
// SudokuLevelView is the main menu where players choose their difficulty.
struct SudokuLevelView: View {
    
    // MARK: Computed properties
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                // Title and Icon
                VStack(spacing: 10) {
                    Image(systemName: "grid.rectangles.3x3")
                        .font(.system(size: 80))
                        .foregroundStyle(.blue)
                    
                    Text("Sudoku Master")
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                .padding(.top, 50)
                
                Text("Select your challenge level:")
                    .font(.headline)
                    .foregroundStyle(.secondary)
                
                // Difficulty Buttons
                VStack(spacing: 20) {
                    ForEach(SudokuDifficulty.allCases, id: \.self) { difficulty in
                        // NavigationLink takes the player to the SudokuView for that level
                        NavigationLink(destination: SudokuView(viewModel: SudokuViewModel(difficulty: difficulty))) {
                            HStack {
                                Text(difficulty.rawValue)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(color(for: difficulty))
                            .foregroundStyle(.white)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                        }
                    }
                }
                .padding(.horizontal, 40)
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // MARK: Functions
    
    // Helper to provide a color theme for each difficulty
    func color(for difficulty: SudokuDifficulty) -> Color {
        switch difficulty {
        case .beginner: return .green
        case .intermediate: return .orange
        case .advanced: return .red
        }
    }
}

#Preview {
    SudokuLevelView()
}
