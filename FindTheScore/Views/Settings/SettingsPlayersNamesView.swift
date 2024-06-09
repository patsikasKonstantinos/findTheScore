//
//  SettingsPlayersView.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 15/9/23.
//

import SwiftUI

struct SettingsPlayersNamesView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var settings: SettingsViewModel
    @State var backButtonClick: Bool = false
    @State var sd: String = "s"

    var body: some View {
        
        GeometryReader { reader in
            ScrollView(.vertical,showsIndicators: false){
                VStack {
                    // BackButton Struct
                    BackButton(dismiss: $backButtonClick)
                    
                    // Players Number
                    HStack {
                        Spacer()
                        Text("ΟΝΟΜΑΤΑ ΠΑΙΚΤΩΝ")
                        Spacer()
                    }
                    .titlesViewsStyle()
                    
                    VStack {
                        ForEach(settings.orderedPlayerNumbers, id: \.self) { playerNumber in
                            if settings.convertToIntPlayerNumber(playerNumber) <= settings.playersCount {
                                VStack {
                                    SuperTextField(
                                        text: Binding(
                                            get: {
                                                settings.playersNames[playerNumber] ?? ""
                                            },
                                            set: { newValue in
                                                settings.playersNames[playerNumber] = newValue
                                            }
                                        ),
                                        placeholder: Text("   Όνομα Παίκτη \(settings.convertToIntPlayerNumber(playerNumber))").foregroundColor(.white)
                                    )
                                    .playersTextFieldsStyle()
                                }
                                .padding(.top, 25)
                            }
                        }
                    }
                    .padding(.bottom, 25)

                    Spacer()
                    
                    HStack{
                       
                        if reader.size.width >= 500 {
                            Spacer()
                        }
                         
                        NavigationLink{
                            SettingsRoundsView()
                        } label: {
                            NextButton(active: settings.activeNextButtonScreen2,text: "ΕΠΟΜΕΝΟ")
                        }
                        .frame(maxWidth: reader.size.width >= 500 ? 200 : .infinity)
                    }
                    .padding(.vertical,15)
                    .disabled(!settings.activeNextButtonScreen2)
                }
                .frame(minHeight: reader.size.height)
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
