//
//  PlayersTextFieldsModifier.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 16/9/23.
//

import SwiftUI

struct PlayersTextFieldsModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(height: 60)
            .frame(maxWidth:.infinity)
    }
}

extension View {
    func playersTextFieldsStyle() -> some View {
        modifier(PlayersTextFieldsModifier())
    }
}
