//
//  GeneralButton.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 15/9/23.
//

import SwiftUI

struct GeneralButton: View {
    
    //MARK: Properties
    let text:String

    var body: some View {
        Text("\(text)")
            .fontWeight(.bold)
            .transition(.scale)
            .frame(maxWidth:.infinity)
            .frame(height:50)
            .contentShape(Rectangle())
            .background(Color.clear)
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.white, lineWidth: 1)
            )
            .foregroundColor(Color.white)
            .padding(.vertical,15)

    }
}
 

