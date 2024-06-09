//
//  SplashScreen.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 15/9/23.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        VStack{
            Image("spls")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .innerStackStyle()
                .frame(maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity)
        .background(Color(red:0.06667,green:0.06667,blue:0.11765,opacity: 1))
        
    }
}

 
