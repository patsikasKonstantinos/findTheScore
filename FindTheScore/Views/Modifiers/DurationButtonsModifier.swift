//
//  DurationButtonsModifier.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 15/9/23.
//

import SwiftUI

struct DurationButtonsModifier: ViewModifier {
    //MARK: Properties
    let gameDuration:GameDuration
    let buttonDuration:GameDuration
    let blueColor = Color(red:0.39608,green:0.53333,blue:0.66667,opacity: 0.7)

    func body(content: Content) -> some View {
        content
            .frame(height:60)
            .frame(maxWidth:.infinity)
            .background(gameDuration == buttonDuration ? blueColor : .clear)
            .contentShape(Rectangle())
            .foregroundColor(.white)
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.white, lineWidth: 1)
            )
    }
}

extension View {
    func durationButtonStyle(_ gameDuration: GameDuration,_ buttonDuration: GameDuration) -> some View {
        modifier(DurationButtonsModifier(gameDuration: gameDuration,buttonDuration:buttonDuration))
    }
}
