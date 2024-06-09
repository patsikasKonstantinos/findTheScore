//
//  ConnectionModeButtonsModifier.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 25/3/24.
//

import SwiftUI
 
struct ConnectionModeButtonsModifier: ViewModifier {
    
    //MARK: Properties
    let mode:ConnectionMode
    let savedGameConnectionMode:ConnectionMode

    let blueColor = Color(red:0.39608,green:0.53333,blue:0.66667,opacity: 0.7)
    
    func body(content: Content) -> some View {
        content
            .frame(height:60)
            .frame(maxWidth:.infinity)
            .background(mode == savedGameConnectionMode ? blueColor : .clear)
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
    func connectionModeButtonsStyle(_ mode: ConnectionMode,_ savedGameConnectionMode: ConnectionMode) -> some View {
        modifier(ConnectionModeButtonsModifier(mode:mode,savedGameConnectionMode:savedGameConnectionMode))
    }
}
