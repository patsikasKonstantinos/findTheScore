//
//  PlayersButtonsModiefier.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 15/9/23.
//

import SwiftUI

struct LeaguesButtonModifier: ViewModifier {
    //MARK: Properties
    let gameLeagues:[GameLeagues]
    let buttonLeague:GameLeagues
    let blueColor = Color(red:0.39608,green:0.53333,blue:0.66667,opacity: 0.7)

    func body(content: Content) -> some View {
        content
            .frame(height:60)
            .frame(maxWidth:.infinity)
            .background(gameLeagues.contains(buttonLeague) ? blueColor : .clear)
            .contentShape(Rectangle())
            .foregroundColor(.white)
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.white, lineWidth: 1)
            )
            .padding(.bottom,15)

    }
}

extension View {
    func leaguesButtonStyle(_ gameLeagues: [GameLeagues],_ buttonLeague: GameLeagues) -> some View {
        modifier(LeaguesButtonModifier(gameLeagues: gameLeagues,buttonLeague:buttonLeague))
    }
}
