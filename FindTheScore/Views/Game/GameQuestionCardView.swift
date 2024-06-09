//
//  GameQuestionCardView.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 16/9/23.
//

import SwiftUI

struct GameQuestionCardView: View {
    @Binding var minimized:Bool
    @Binding var newRoundPlayButton:Bool
    @Binding var enableTimer:Bool
    let roundNumber:Int
    let gameRoundsCount:Int
    let gamePlayerRound:Int
    let questionShortText:String
    let questionFullText:String
    let questionCategory:String

    var body: some View {
        VStack{
            Text("\(gamePlayerRound) / \(gameRoundsCount)")
                .fontWeight(.bold)
                .frame(maxWidth:.infinity)
                .frame(height:50)
                .background(Color.white)
                .foregroundColor(Color(red:0.39608,green:0.53333,blue:0.66667,opacity: 1))
                .padding(.bottom,5)
            
            Spacer()
            
            Text(questionCategory)
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(Color.blue)
                .padding(.bottom,5)
            
            Text("\(questionFullText)")
                .font(.body)
                .fontWeight(.bold)
                .frame(maxWidth:.infinity,alignment: .center)

                //otan exoyme multine text
                .multilineTextAlignment(.center)
                .padding(.horizontal,15)
                .foregroundColor(Color.black)
            
            Spacer()
            
            if enableTimer {
                if minimized {
                    Image("iconDown")
                        .resizable()
                        .expandImageModifier()
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 1)){
                                minimized = false
                            }
                        }
                }else{
                    Image("iconUp")
                        .resizable()
                        .expandImageModifier()
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 1)){
                                minimized = true
                            }
                        }
                }
            }
             
        }
        .frame(maxHeight: !minimized ? 380 : 150)
        .background(Color.white)
        .opacity(0.7)
        .background(
            Image("question")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.2)
                .padding(.top,50)
        )
        .cornerRadius(25)
        .overlay(
            //border sto radius viewer
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.white, lineWidth: 3)
        )
    }
}

 
