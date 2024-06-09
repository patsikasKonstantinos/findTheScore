//
//  WarningView.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 24/3/24.
//

import SwiftUI

struct WarningView: View {
    @Binding var showingAlert:Bool
    let messages:[String]
    let width:Double
    let height:Double
    var body: some View {
        VStack(alignment:.center){
            Image(systemName: "clear.fill")
                .resizable()
                .foregroundColor(.red)
                .frame(width: 70,height: 70)
                .cornerRadius(50)
                .padding(15)
            
            VStack{
                ForEach(messages, id: \.self){ message in
                    Text("\(message)")
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true) // Enable multiline
                        .padding(.leading,5)
                        .padding(.trailing,15)
                        .padding(.bottom,5)
                }
            }
            .frame(maxHeight:.infinity,alignment: .center)
            
            Spacer()
            
            Text("Close")
                .font(.system(size: 18))
                .foregroundColor(.blue)
                .frame(maxWidth:.infinity)
                .frame(height:50)
                .background(.gray.opacity(0.01))
                .overlay(
                    Rectangle()
                        .frame(height: 1) // Adjust the height of the border as needed
                        .foregroundColor(.gray.opacity(0.2)) // Adjust the border color as needed
                        .padding(.top, -25)
                )
                .onTapGesture {
                      withAnimation{
                          showingAlert = false
                      }
                }
        }
        .frame(width:width,height:height)
        .background(.white)
        .cornerRadius(5)
        .transition(.scale)
        .cornerRadius(10)
    }
}

