//
//  GeneralSettingsView.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 25/3/24.
//

import SwiftUI
 
struct GeneralSettingsView: View {
    
    //MARK: Initialization
    @Environment(\.dismiss) var dismiss
    @StateObject var settings: SettingsViewModel
    @State var backButtonClick:Bool = false
    
    var body: some View {
        VStack{
            
//            BackButton(dismiss: $backButtonClick)

            Text("Mode")
                .fontWeight(.bold)
                .titlesViewsStyle()
                .padding(EdgeInsets(.init(top: 25, leading: 0, bottom: 25, trailing: 0)))
                                                
            HStack{
                  
                Text("Offline")
                    .connectionModeButtonsStyle(.offline, settings.savedGameConnectionMode)
                    .onTapGesture {
                        settings.setGameConnectionMode(.offline)
                    }
                
                Text("Online")
                    .connectionModeButtonsStyle(.online, settings.savedGameConnectionMode)
                    .onTapGesture {
                        settings.setGameConnectionMode(.online)
                    }

            }
            .padding(.horizontal,5)

            Spacer()

        }
        .onAppear{
            settings.getGameConnectionMode()
        }
        .onChange(of: backButtonClick) { backButton in
            if backButton {
                dismiss()
            }
        }
        .padding()
        .presentationDetents([ .medium, .large])
        .presentationBackground(.thinMaterial)
    }
}
 
