//
//  TitlesViewModifier.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 15/9/23.
//

import SwiftUI
 
struct TitlesViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .frame(maxWidth:.infinity)
            .frame(height:50)
            .background(Color.white)
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.white, lineWidth: 1)
            )
            .foregroundColor(Color(red:0.39608,green:0.53333,blue:0.66667,opacity: 1))
            
            
    }
}

extension View {
    func titlesViewsStyle() -> some View {
        modifier(TitlesViewModifier())
    }
}


 
