//
//  GameQuestionViewModel.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 23/9/23.
//

import SwiftUI

class GameQuestionViewModel:ObservableObject{
    
    //MARK: Properties
    @Published var backButtonClick: Bool = false
    @Published var minimized: Bool = false
    @Published var newRound: Bool = false
    @Published var newRoundPlayButton: Bool = false
    @Published var nextPlayerButton: Bool = false
    @Published var enableTimer : Bool = false
    @Published var gameTimeCounter:Int = 0
    @Published var navigateToScore:Bool = false
    let generator = UIImpactFeedbackGenerator(style: .heavy)
    
    //MARK: Functions
    func setup(_ gameDurationSeconds:Int){
        backButtonClick = false
        minimized = false
        newRound  = false
        newRoundPlayButton = false
        nextPlayerButton  = false
        enableTimer  = false
        gameTimeCounter = gameDurationSeconds
    }
    
    func vibrationListener(){
        if gameTimeCounter == 10 {
            UIDevice.vibrate()
        }
        else if gameTimeCounter < 10{
            generator.impactOccurred()
        }
    }
}
