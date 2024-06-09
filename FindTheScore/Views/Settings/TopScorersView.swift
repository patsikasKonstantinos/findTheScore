//
//  GameResultsView.swift
//  find_the_score
//
//  Created by Κωνσταντίνος Πατσίκας on 2/4/22.
//

import SwiftUI
 
struct TopScoresView: View {
    @State var topPlayerScore:Int
    @State var topPlayerName:String

    var body: some View {
        VStack{
            
            if(topPlayerScore>0){
                Text("\(topPlayerName)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Text("\(topPlayerScore)")
                    .foregroundColor(.white)
                    .fontWeight(.bold)

                Image("winner")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }else{
                Text("Δεν βρέθηκε εγγραφή")
                    .font(.body)
                    .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
//        .viewWrapperStyle()

    }
}
