//
//  ViewWrapperModifier.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 15/9/23.
//

import SwiftUI

struct ViewWrapperModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .navigationBarBackButtonHidden(true)
            .padding()
            .background(
                Image("background_admin")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .scaledToFill()
                    .ignoresSafeArea()
            )
    }
}

extension View {
    func viewWrapperStyle() -> some View {
        modifier(ViewWrapperModifier())
    }
}
    
    

