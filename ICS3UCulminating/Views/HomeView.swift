//
//  HomeView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026/6/4.
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - Stored properties
    
    // Access the game manager from the environment
    @Environment(GameManager.self) var gameManager
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                Text("Sudoku")
                    .font(.system(size: 60, weight: .bold, design: .rounded))
                    .padding(.top, 50)
                
                VStack(spacing: 20) {
                    NavigationLink {
                        SudokuView(viewModel: gameManager.easyViewModel)
                    } label: {
                        LevelButtonLabel(title: "Easy", color: .green)
                    }
                    
                    NavigationLink {
                        SudokuView(viewModel: gameManager.mediumViewModel)
                    } label: {
                        LevelButtonLabel(title: "Medium", color: .orange)
                    }
                    
                    NavigationLink {
                        SudokuView(viewModel: gameManager.hardViewModel)
                    } label: {
                        LevelButtonLabel(title: "Hard", color: .red)
                    }
                }
                .padding(.horizontal, 40)
                
                Spacer()
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(GameManager())
}
