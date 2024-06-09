//
//  Enums.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 16/9/23.
//

import Foundation

enum GamePlayers{
    case none, twoPlayers, threePlayers, fourPlayers
}

enum GamePlayersNumber{
    case none, player1, player2, player3, player4
}

enum GameLeagues{
    case none, greekSuperLeague, championsLeague, europaLeague
}

enum GameRounds {
    case none,ten,fifteen,twenty
}

enum GameDuration {
    case none,thirty,sixty,ninty
}

enum ScorerHomeOrAway {
    case none,home,away
}

enum ConnectionMode:Codable {
    case offline,online
}
