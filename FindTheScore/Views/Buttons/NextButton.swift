//
//  NextButton.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 15/9/23.
//

import SwiftUI

struct NextButton: View {
    
    //MARK: Properties
    let active:Bool
    let text:String

    var body: some View {
        Text("\(text)")
            .fontWeight(.bold)
            .frame(maxWidth:.infinity)
            .frame(height: 50)
            .background(Color.clear)
            .cornerRadius(15)
            .opacity(active ? 1 : 0.5)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.white, lineWidth: 1)
            )
            
            .foregroundColor(Color.white)
             
    }
}
 
