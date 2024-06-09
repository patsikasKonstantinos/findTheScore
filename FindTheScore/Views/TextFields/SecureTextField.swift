//
//  SecureTextField.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 16/9/23.
//

import SwiftUI

//CUSTOM STRUCT ΓΙΑ TEXTFIELD
struct SuperTextField: View {
    
    //MARK: Properties
    @Binding var text: String
    var placeholder: Text
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            TextField(" ", text: $text, onEditingChanged: editingChanged, onCommit: commit)
                .frame(maxWidth:.infinity)
                .frame(height:70)
                .padding(.horizontal,10)
                .foregroundColor(.white)
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.white, lineWidth: 1))
        }
    }
}
