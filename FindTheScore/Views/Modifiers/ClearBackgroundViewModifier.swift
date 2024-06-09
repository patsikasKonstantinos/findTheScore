//
//  ClearBackgroundView.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 25/9/23.
//

import SwiftUI

struct ClearBackgroundViewModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .background(ClearBackgroundView())
    }
}

extension View {
    func clearModalBackground()->some View {
        self.modifier(ClearBackgroundViewModifier())
    }
}
