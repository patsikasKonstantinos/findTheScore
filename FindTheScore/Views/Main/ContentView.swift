//
//  ContentView.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 15/9/23.
//

import SwiftUI

struct ContentView: View {
    var settings:SettingsViewModel
    //var testCall:ApiCalls = ApiCalls()
    @State var displaySplashScreen = true
    
    
    //MARK: Body
    var body: some View {
                  
        if displaySplashScreen {
            SplashScreenView()
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        displaySplashScreen = false
                    }
                }
        }else{
            //Skip Intro
            if settings.getSkipIntroBoolean(){
                NavigationStack{
                    BasicSettingsView()
                }
                .environmentObject(settings)
            }
            else{
                IntroScreenView()
                    .environmentObject(settings)
            }
        }
         
    }
}
 
