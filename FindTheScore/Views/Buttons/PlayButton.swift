//
//  PlayButton.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 27/9/23.
//

import SwiftUI

struct PlayButton: View {
    
    //MARK: Properties
    let text:String

    var body: some View {
        Text("\(text)")
            .fontWeight(.bold)
            .transition(.scale)
            .frame(maxWidth:.infinity)
            .frame(height:50)
            .contentShape(Rectangle())
            .background(.white)
            .opacity(0.7)
            .cornerRadius(25)
            .overlay(
                //border sto radius viewer
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.white, lineWidth: 3)
            )
            .foregroundColor(.black)
            .padding(.vertical,15)

    }
}
