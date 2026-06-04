//
//  ICS3UCulminatingApp.swift
//  ICS3UCulminating
//
//  Created by 黃翊喬 on 2026/6/1.
//

import SwiftUI

@main
struct ICS3UCulminatingApp: App {
    @State private var gameManager = GameManager()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(gameManager)
        }
    }
}
