//
//  LevelButtonLabel.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026/6/6.
//

import SwiftUI

// MARK: - Helper Views

struct LevelButtonLabel: View {
    let title: String
    let color: Color
    
    var body: some View {
        Text(title)
            .font(.title)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(color)
            .cornerRadius(15)
            .shadow(radius: 5)
    }
}
