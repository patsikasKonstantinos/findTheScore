//
//  SettingsPlayersView.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 15/9/23.
//

import SwiftUI

struct SettingsRoundsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var settings: SettingsViewModel
    @State var backButtonClick: Bool = false
    @State var readyToStart:Bool = false
    @State var serviceError:Bool = false
 
    var body: some View {
        
        GeometryReader { reader in
            ZStack{
                ScrollView(.vertical,showsIndicators: false){
                    VStack {
                        
                        if !serviceError{
                            
                            // BackButton Struct
                            BackButton(dismiss: $backButtonClick)
                            
                            // Players Number
                            HStack {
                                Spacer()
                                Text("ΓΥΡΟΙ ΠΑΙΧΝΙΔΙΟΥ")
                                Spacer()
                            }
                            .titlesViewsStyle()
                            
                            HStack{
                               Text("10")
                                   .roundsButtonStyle(settings.gameRounds, .ten)
                                   .onTapGesture {
                                       settings.setGameRounds(.ten)
                                   }
                               
                               Text("15")
                                   .roundsButtonStyle(settings.gameRounds, .fifteen)
                                   .onTapGesture {
                                       settings.setGameRounds(.fifteen)
                                   }
                               
                               Text("20")
                                   .roundsButtonStyle(settings.gameRounds, .twenty)
                                   .onTapGesture {
                                       settings.setGameRounds(.twenty)
                                   }
                               
                            }
                            .padding(.vertical, 25)
                            
                            HStack {
                               Spacer()
                               
                               Text("ΔΙΑΡΚΕΙΑ ΠΑΙΧΝΙΔΙΟΥ")
                               
                               Spacer()
                           }
                           .titlesViewsStyle()
                            
                            HStack{
                                                   
                                Text("30")
                                    .durationButtonStyle(settings.gameDuration, .thirty)
                                    .onTapGesture {
                                        settings.setGameDuration(.thirty)
                                    }
                                
                                Text("60")
                                    .durationButtonStyle(settings.gameDuration, .sixty)
                                    .onTapGesture {
                                        settings.setGameDuration(.sixty)
                                    }
                                
                                Text("90")
                                    .durationButtonStyle(settings.gameDuration, .ninty)
                                    .onTapGesture {
                                        settings.setGameDuration(.ninty)
                                    }
                                
                            }
                            .padding(.vertical,25)

                            Spacer()
                             
                            HStack{
                               
                                if reader.size.width >= 500 {
                                    Spacer()
                                }
                                 
                                HStack{
                                    NextButton(active: settings.activeNextButtonScreen3,text: "ΕΠΟΜΕΝΟ")
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    
                                    //Do no run if service already running
                                    if !settings.loadQuestionsLoader {
                                        
                                        if settings.activeNextButtonScreen3{
                                            settings.loadQuestionsLoader = true
                                            settings.setupGame(){ systemResponse in
                                                
                                                if systemResponse!.success {
                                                    readyToStart = true
                                                }
                                                else{
                                                    withAnimation{
                                                        serviceError = true
                                                    }
                                                }
                                                settings.loadQuestionsLoader = false
                                             }
                                        }
                                    }
                                   
                                }
                                .frame(maxWidth: reader.size.width >= 500 ? 200 : .infinity)
                            }
                            .padding(.vertical,15)
                        }
                        else{
                            //Warning
                            WarningView(
                                showingAlert:$serviceError,
                                messages: ["An error occurred","Please try again later!"],
                                width: 300,
                                height: 250
                            )
                        }
                     
                    }
                    .frame(minWidth:reader.size.width,minHeight: reader.size.height)
                }
                
                if settings.loadQuestionsLoader {
                    ProgressView()
                        .progressViewStyle()
                }
                 
            }
             
        }
        .navigationDestination(isPresented: $readyToStart){
            GameQuestionView(gameQuestionViewModel: GameQuestionViewModel())
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
