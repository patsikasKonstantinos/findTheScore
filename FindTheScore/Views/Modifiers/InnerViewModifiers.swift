//
//  InnerViewModifier.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 15/9/23.
//

import SwiftUI

struct InnerViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: 600)
    }
}

extension View {
    func innerViewStyle() -> some View {
        modifier(InnerViewModifier())
    }
}

struct InnerStackModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: 500)
    }
}

extension View {
    func innerStackStyle() -> some View {
        modifier(InnerStackModifier())
    }
}
    
    

