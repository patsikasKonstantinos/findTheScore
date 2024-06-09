//
//  FindTheScoreApp.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 15/9/23.
//

import SwiftUI

@main
struct FindTheScoreApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(settings: SettingsViewModel())
        }
    }
}
