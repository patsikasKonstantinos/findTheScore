//
//  RoundsButtonsModifier.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 15/9/23.
//

import SwiftUI

struct RoundsButtonsModifier: ViewModifier {
    //MARK: Properties
    let gameRounds:GameRounds
    let buttonRound:GameRounds
    let blueColor = Color(red:0.39608,green:0.53333,blue:0.66667,opacity: 0.7)

    func body(content: Content) -> some View {
        content
            .frame(height:60)
            .frame(maxWidth:.infinity)
            .background(gameRounds == buttonRound ? blueColor : .clear)
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
    func roundsButtonStyle(_ gameRounds: GameRounds,_ buttonRound: GameRounds) -> some View {
        modifier(RoundsButtonsModifier(gameRounds: gameRounds,buttonRound:buttonRound))
    }
}
