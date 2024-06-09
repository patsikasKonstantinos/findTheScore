//
//  IntroScreenView.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 15/9/23.
//

import SwiftUI

struct IntroScreenView: View {
    
    //MARK: Properties
    @StateObject var introViewModel: IntroViewModel = IntroViewModel()
    
    var body: some View {
        NavigationStack{
            VStack{
                TabView{
                    VStack{
                        Text("\(introViewModel.introTextScreen1)")
                            .foregroundColor(Color.white)
                        
                        Spacer()
                    }
                    .tag(1)
                    
                    VStack{
                        Text("\(introViewModel.introTextScreen2)")
                            .foregroundColor(Color.white)
                             
                        Spacer()
                        
                        HStack{
                            Spacer()
                            
                            NavigationLink{
                                BasicSettingsView()
                            } label: {
                                Text("ΕΠΟΜΕΝΟ")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                                    .padding(15.0)
                            }
                        }
                        .padding(.bottom, 30)
                    }
                    .tag(2)
                }
                .tabViewStyle(PageTabViewStyle())
            }
            .padding()
            .background(Color.black)
        }
    }
}
 
