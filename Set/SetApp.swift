//
//  SetApp.swift
//  Set
//
//  Created by Joshua Galvan on 3/20/23.
//

import SwiftUI

@main
struct SetApp: App {
    let game = CustomSetGame()
    var body: some Scene {
        WindowGroup {
            SetGameView(game: game)
        }
    }
}
