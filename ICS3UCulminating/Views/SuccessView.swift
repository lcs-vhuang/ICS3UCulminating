//
//  SuccessView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026/6/4.
//

import SwiftUI

struct SuccessView: View {
    
    // MARK: - Stored properties
    
    let difficulty: String
    let timeUsed: String
    
    // Used to go back to the home screen
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            // Background to catch taps anywhere
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.green)
                
                VStack(spacing: 10) {
                    Text("Congratulations!")
                        .font(.largeTitle)
                        .fontWeight(.black)
                    
                    Text("You have finished \(difficulty) Level!" )
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                    Text("Time \(timeUsed)")
                        .fontWeight(.medium)
                        .foregroundStyle(.blue)
                }
                
                Text("Tap anywhere to return home")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top, 40)
            }
            .padding()
        }
        .onTapGesture {
            // This will dismiss the SuccessView, which is presented as a fullScreenCover
            dismiss()
        }
    }
}

#Preview {
    SuccessView(difficulty: "Easy", timeUsed: "02:45")
}
