//
//  ClearBackgroundView.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 24/3/24.
//

import SwiftUI

struct ClearBackgroundView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
//            view.superview?.superview?.layer.opacity = 0.4

        }
        return view
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
 
