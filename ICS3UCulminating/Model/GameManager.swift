//
//  GameManager.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026/6/4.
//

import Foundation
import Observation

@Observable
class GameManager {
    
    // MARK: - Stored properties
    
    // Hold separate view models for each difficulty level to preserve progress.
    var easyViewModel = SudokuViewModel(difficulty: .beginner)
    var mediumViewModel = SudokuViewModel(difficulty: .intermediate)
    var hardViewModel = SudokuViewModel(difficulty: .advanced)
    
}
