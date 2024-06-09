//
//  BackButton.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 15/9/23.
//

import SwiftUI

struct BackButton: View {
    
    //MARK: Properties
    @Binding var dismiss:Bool
    
    var body: some View {
        HStack{
            Image("backbutton")
                .resizable()
                .scaledToFit()
                .frame(height: 30)
                .onTapGesture {
                    dismiss = true
                }
                .padding(.leading,15)
            
            Spacer()
        }
        .padding(.bottom,25)

    }
}
 
