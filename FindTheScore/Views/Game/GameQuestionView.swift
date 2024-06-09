//
//  GameQuestionView.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 15/9/23.
//

import SwiftUI

struct GameQuestionView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var settings: SettingsViewModel
    @StateObject var gameQuestionViewModel: GameQuestionViewModel
    @State var timer = Timer.publish(every:1, on: .main, in: .common).autoconnect()
    @State var newRoundPlayButton:Bool = false
    @State var newRound:Bool = false
    
    var body: some View {
        
        //If Game is Active
        GeometryReader { geometry in
            // Get the geometry
            
            if gameQuestionViewModel.enableTimer {
                HStack{
                    Spacer()
                    
                    Image("forwardbutt")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                        .onTapGesture {
                            settings.checkEndGame()
                            gameQuestionViewModel.navigateToScore = true
                            gameQuestionViewModel.setup(settings.gameDurationSeconds)
                            
                        }
                        .padding(.leading,15)
                }
                .zIndex(1)
            }
            
            ScrollView(.vertical,showsIndicators: false) {
                VStack{

                    HStack{
                        Text("\(settings.currPlayerName)")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }
                    
                    VStack{
                        if newRound {
                            GameQuestionCardView(
                                minimized: $gameQuestionViewModel.minimized,
                                newRoundPlayButton:$newRoundPlayButton,
                                enableTimer:$gameQuestionViewModel.enableTimer,
                                roundNumber:settings.currGameRound,
                                gameRoundsCount:settings.gameRoundsCount,
                                gamePlayerRound:settings.currGamePlayerRound ,
                                questionShortText:settings.currQuestion?.title ?? "",
                                questionFullText: settings.currQuestion?.text ?? "",
                                questionCategory: settings.currQuestion?.category ?? ""
                            )
                            .transition(.move(edge: .bottom))
                        }
                        
                        if newRoundPlayButton {
                            GeneralButton(text:"ΠΑΙΞΕ")
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    withAnimation(.easeInOut(duration: 1.5)){
                                        gameQuestionViewModel.minimized = true
                                        newRoundPlayButton = false
                                        gameQuestionViewModel.enableTimer = true
                                    }
                                }
                        }
                    }
                    .padding()
                    .frame(width: geometry.size.width)
                    .frame(minHeight: gameQuestionViewModel.minimized ? 150 : gameQuestionViewModel.enableTimer ? geometry.size.height/2 : geometry.size.height)
                    
                    if gameQuestionViewModel.enableTimer {
                        VStack{
                            Text("\(gameQuestionViewModel.gameTimeCounter)")
                                .timeCounter(gameQuestionViewModel.gameTimeCounter > 10 ? .white : .red)
                        }
                        .padding()
                        .onReceive(timer) { input in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                if(gameQuestionViewModel.gameTimeCounter > 0){
                                    gameQuestionViewModel.gameTimeCounter = gameQuestionViewModel.gameTimeCounter - 1
                                    gameQuestionViewModel.vibrationListener()
                                }
                            }
                         }
                        .transition(.move(edge: .leading))
                        .frame(minHeight: geometry.size.height/4)

                    }
                    
                    if gameQuestionViewModel.enableTimer {
                        if gameQuestionViewModel.minimized{
                            Text("\(settings.currQuestion?.score ?? "" )")
                                .matchScore(settings.successScoreSelect ? .white : .black, settings.successScoreSelect ? .green : .white)
                                .onTapGesture {
                                    settings.successScoreSelect.toggle()
                                    settings.setGamePlayersScore(settings.successScoreSelect,true)
                                }
                        }
                        
                        if gameQuestionViewModel.minimized{
                         
                            if settings.successScorerSelect.count > 0 {

                                ScrollView{
                                    VStack(spacing: 0) {
                                        ForEach(0..<settings.successScorerSelect.count,id:\.self) { row in
                                            if settings.currQuestionScorers.indices.contains(row) {
                                                Text("\(settings.currQuestionScorers[row].replacingOccurrences(of:"1!", with: "").replacingOccurrences(of:"2!", with: ""))")
                                                    .matchScorers(settings.successScorerSelect[row] ? .white : .black, settings.successScorerSelect[row] ? Color(red:85/255,green:160/255,blue:95/255) : .clear, settings.currQuestionScorers[row].prefix(1) == "1" ? .leading : .trailing)
                                                    .onTapGesture {
                                                        settings.successScorerSelect[row].toggle()
                                                        settings.setGamePlayersScore(settings.successScorerSelect[row],false)
                                                    }
                                                    
                                                    if row < settings.currQuestionScorers.count{
                                                        Divider()
                                                            .background(Color.gray)
                                                    }
                                            }
                                        }
                                    }
                                }
                                .background(.white.opacity(0.7))
                                .frame(maxHeight:150)
                                .transition(.move(edge: .trailing))
                                .cornerRadius(25)
                                .overlay(
                                    //border sto radius viewer
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.white, lineWidth: 3)
                                )
                                .padding(.horizontal)
                                 
                            }
                        }
                    }
                }
            
                .frame(minHeight: geometry.size.height)
            }
            .zIndex(0)
        }
        .navigationDestination(isPresented: $gameQuestionViewModel.navigateToScore) {
            GameScoreView()
        }
        .onAppear{
            gameQuestionViewModel.setup(settings.gameDurationSeconds)
            withAnimation(.easeInOut(duration: 1)) {
                newRound = true
            }
            withAnimation(.easeInOut(duration: 1.5)) {
                newRoundPlayButton = true
            }
            settings.checkEndGame()
            
        }
        .onDisappear{
            newRound = false
            gameQuestionViewModel.newRound = false
        }
        .innerViewStyle()
        .viewWrapperStyle()
    }
}
