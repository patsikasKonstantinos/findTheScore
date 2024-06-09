//
//  ProgressViewModifier.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 24/3/24.
//

import SwiftUI

struct ProgressViewModifier: ViewModifier {
     
    func body(content: Content) -> some View {
        content
            .progressViewStyle(CircularProgressViewStyle())
            .frame(width: 50, height: 50)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding(30)

    }
}

extension View {
    func progressViewStyle() -> some View {
        modifier(ProgressViewModifier())
    }
}
