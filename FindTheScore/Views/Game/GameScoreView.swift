//
//  GameScoreView.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 23/9/23.
//

import SwiftUI

struct GameScoreView: View {
    @EnvironmentObject var settings: SettingsViewModel
    @State var backButtonClick: Bool = false
    @State var displayPoints: Bool = false
    @State var nextPlayerButton: Bool = false
    @State var nextGameButton: Bool = false
    @State var newGame: Bool = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical,showsIndicators: false){
                VStack {
                    if !settings.finishGame {
                        Text("ΓΥΡΟΣ \(settings.currGamePlayerRound) / \(settings.gameRoundsCount)")
                            .titlesViewsStyle()
                        
                        if displayPoints{
                            Text("\(settings.currPlayerName) κέρδισες \(settings.currQuestionPoints) βαθμούς!")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.center)
                                .padding(.vertical,25)
                                .transition(.opacity)
                            
                            VStack{
                                ForEach(settings.topScorers, id: \.0) { (player, score) in
                                    VStack{
                                        Text(" \(settings.playersNames[player]!) :  \(score) βαθμούς")
                                            .padding(.top,10)
                                            .foregroundColor(Color.white)
                                        
                                        ProgressView(value: Double(score),total: Double(settings.topScore+100))
                                    }
                                    
                                }
                            }
                            .frame(maxWidth: geometry.size.width * 0.8)
                            .transition(.opacity)
                        }
                    }
                    else{
                        Text("\(settings.currPlayerName) κέρδισες \(settings.currQuestionPoints) βαθμούς!")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                            .padding(.vertical,25)
                    }
                    
                    
                    if settings.finishGame{
                        Text("AΠΟΤΕΛΕΣΜΑΤΑ")
                            .fontWeight(.bold)
                            .frame(height:50)
                            .background(Color.clear)
                             
                            .foregroundColor(Color.white)
                        
                            if !settings.gameDraw {
                                ZStack {
                                   Circle()
                                       .fill(Color.blue)
                                       .frame(width: 12, height: 12)
                                       .modifier(ParticlesModifier())
                                       .offset(x: -100, y : -50)
                                   
                                   Circle()
                                       .fill(Color.red)
                                       .frame(width: 12, height: 12)
                                       .modifier(ParticlesModifier())
                                       .offset(x: 60, y : 70)
                               }
                                
                               Text("ΣΥΓΧΑΡΗΤΗΡΙΑ\nΝΙΚΗΤΗΣ ΕΙΝΑΙ Ο ΠΑΙΚΤΗΣ \(settings.winnerName)")
                                    .titlesViewsStyle()
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom,5)
                                    .frame(height:90)
                            }
                            else{
                                Text("ΟΥΠΣ...ΠΡΟΕΚΥΨΕ ΙΣΟΠΑΛΙΑ")
                                    .titlesViewsStyle()
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom,5)
                                    .frame(height:90)
                            }
                    }
                                    
                    Spacer()
                    
                    if !settings.finishGame {
                        if nextPlayerButton {
                            VStack{
                                GeneralButton(text: "EΠΟΜΕΝΟΣ ΠΑΙΚΤΗΣ")
                            }
                            .frame(maxWidth:geometry.size.width > 500 ? 320 : .infinity)
                            .padding(.bottom,-15)
                            .transition(.move(edge: .leading))
                            .onTapGesture {
                                settings.nextPlayer()
                                dismiss()
                            }
                        }
                    }

                    if nextGameButton {
                        VStack{
                            GeneralButton(text: "NEO ΠΑΙΧΝΙΔΙ")
                            
                        }
                        .frame(maxWidth:geometry.size.width > 500 ? 320 : .infinity)
                        .onTapGesture {
                            settings.reset()
                            newGame = true
                        }
                        .transition(!settings.finishGame ? .move(edge: .trailing) : .opacity)
                    }
                }
                .frame(minHeight: geometry.size.height,alignment: .center)
            }
        }
        .navigationDestination(isPresented: $newGame) {
            BasicSettingsView()
        }
         
        .onAppear{
            //Delay for animations purpose
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeInOut(duration: 1)) {
                    displayPoints = true
                    nextGameButton = true
                    nextPlayerButton = true
                }
            }
        }
       
        .onChange(of: backButtonClick) { backButton in
            if backButton {
                dismiss()
            }
        }
        .innerViewStyle()
        .viewWrapperStyle()
    }
}
