//
//  BasicSettingsView.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 15/9/23.
//

import SwiftUI

struct BasicSettingsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var settings: SettingsViewModel
    @State var backButtonClick: Bool = false
    @State var showingTopScores:Bool = false
    @State var showingSettings:Bool = false
    
    var body: some View {
        
        GeometryReader { reader in
            ScrollView(.vertical,showsIndicators: false){
                VStack {
//                  // BackButton Struct
//                  BackButton(dismiss: $backButtonClick)
                    
                    HStack{
                        Spacer()
                        
                        Image(systemName: "gear")
                            .resizable()
                            .frame(width: 25,height: 25)
                            .foregroundColor(.white)
                            .onTapGesture {
                                showingSettings.toggle()
                            }
                            .sheet(isPresented: $showingSettings) {
                                GeneralSettingsView(settings: settings)
                            }
                    }
                    .padding(.bottom,15)
                    
                    // Players Number
                    HStack {
                        Spacer()
                        
                        Text("ΠΑΙΚΤΕΣ")
                            .padding(.leading, settings.savedTopScore() > 0 ? 55 : 0)
                        
                        Spacer()
                        
                        if settings.savedTopScore() > 0 {
                             
                            Image("award")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .padding(.trailing, 25)
                                .onTapGesture{
                                    showingTopScores.toggle()
                                }
                                .sheet(isPresented: $showingTopScores) {
                                    TopScoresView(topPlayerScore: settings.savedTopScore(), topPlayerName: settings.savedTopScorer())
                                        .presentationDetents([ .medium, .large])
                                        .presentationBackground(.thinMaterial)
                                }
                        }
                    }
                    .titlesViewsStyle()
                    
                    HStack {
                        Text("2")
                            .playersButtonStyle(settings.gamePlayers, .twoPlayers)
                            .onTapGesture {
                                settings.setGamePlayers(.twoPlayers)
                            }
                        
                        Text("3")
                            .playersButtonStyle(settings.gamePlayers, .threePlayers)
                            .onTapGesture {
                                settings.setGamePlayers(.threePlayers)
                            }
                        
                        Text("4")
                            .playersButtonStyle(settings.gamePlayers, .fourPlayers)
                            .onTapGesture {
                                settings.setGamePlayers(.fourPlayers)
                            }
                    }
                    .padding(.top, 25)

                    VStack {
                        Text("ΔΙΟΡΓΑΝΩΣΕΙΣ")
                            .titlesViewsStyle()
                            
                        HStack{}.padding(.top, 25)
                        
                        Text("Greek Super League")
                            .leaguesButtonStyle(settings.gameLeagues, .greekSuperLeague)
                            .onTapGesture {
                                settings.setGameLeagues(.greekSuperLeague)
                            }
                        
                        Text("Europa League")
                            .leaguesButtonStyle(settings.gameLeagues, .europaLeague)
                            .onTapGesture {
                                settings.setGameLeagues(.europaLeague)
                            }
                        
                        Text("Champions League")
                            .leaguesButtonStyle(settings.gameLeagues, .championsLeague)
                            .onTapGesture {
                                settings.setGameLeagues(.championsLeague)
                            }
                    }
                    .padding(.top, 25)
                    
                    Spacer()
                    
                    HStack{
                       
                        if reader.size.width >= 500 {
                            Spacer()
                        }
                         
                        NavigationLink{
                            SettingsPlayersNamesView()
                        } label: {
                            NextButton(active: settings.activeNextButtonScreen1,text: "ΕΠΟΜΕΝΟ")
                        }
                        .frame(maxWidth: reader.size.width >= 500 ? 200 : .infinity)
                    }
                    .padding(.vertical,15)
                    .disabled(!settings.activeNextButtonScreen1)
                }
                .frame(minHeight: reader.size.height)
            }
        }
        .onAppear{
            settings.skipIntro()
//            settings.reset()
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
