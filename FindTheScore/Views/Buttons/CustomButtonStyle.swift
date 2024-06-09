//
//  CustomButtonStyle.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 17/9/23.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(configuration.isPressed ? Color.blue.opacity(0.8) : Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}
