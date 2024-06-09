//
//  GameButtonsModifiers.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 16/9/23.
//

import SwiftUI

struct ExpandImageModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(height: 25)
            .frame(width: 25)
            .scaledToFit()
            .foregroundColor(Color.black)
            .padding(.top, 5)
            .padding(.bottom, 10)
            
    }
}

struct TimeCounter: ViewModifier {
    let color:Color
    func body(content: Content) -> some View {
        content
            .fontWeight(.bold)
            .font(.system(size: 70))
            .frame(maxWidth:.infinity)
            .background(.clear)
            .foregroundColor(color)            
    }
}

struct MatchScore: ViewModifier {
    let color:Color
    let backgroundColor:Color
    
    func body(content: Content) -> some View {
        content
            .fontWeight(.bold)
            .foregroundColor(color)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(backgroundColor)
            .opacity(0.7)
            .cornerRadius(25)
            .overlay(
                //border sto radius viewer
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.white, lineWidth: 3)
            )
            .transition(.move(edge: .leading))
            .padding(.horizontal)
    }
}

struct MatchScorers: ViewModifier {
    let color:Color
    let backgroundColor:Color
    let alignment:Alignment
    
    func body(content: Content) -> some View {
        content
            .padding(.horizontal,15)
            .frame(height:40)
            .frame(maxWidth:.infinity,alignment:alignment)
            .contentShape(Rectangle())
            .background(backgroundColor)
            .foregroundColor(color)
        
    }
}

struct FireworkParticlesGeometryEffect : GeometryEffect {
    var time : Double
    var speed = Double.random(in: 20 ... 30)
    var direction = Double.random(in: -Double.pi ...  Double.pi)
    
    var animatableData: Double {
        get { time }
        set { time = newValue }
    }
    func effectValue(size: CGSize) -> ProjectionTransform {
        let xTranslation = speed * cos(direction) * time
        let yTranslation = speed * sin(direction) * time
        let affineTranslation =  CGAffineTransform(translationX: xTranslation, y: yTranslation)
        return ProjectionTransform(affineTranslation)
    }
}

struct ParticlesModifier: ViewModifier {
    @State var time = 0.0
    @State var scale = 0.1
    let duration = 15.0
    
    func body(content: Content) -> some View {
        ZStack {
            ForEach(0..<100, id: \.self) { index in
                content
                    .hueRotation(Angle(degrees: time * 300))
                    .scaleEffect(scale)
                    .modifier(FireworkParticlesGeometryEffect(time: time))
                    .opacity(((duration-time) / duration))
            }
        }
        .onAppear {
            withAnimation (.easeOut(duration: duration)) {
                self.time = duration
                self.scale = 1.0
            }
        }
    }
}


extension Image {
    func expandImageModifier() -> some View {
        modifier(ExpandImageModifier())
    }
}

extension View {
    func timeCounter(_ color:Color) -> some View {
        modifier(TimeCounter(color:color))
    }
    
    func matchScore(_ color:Color,_ backgroundColor:Color) -> some View {
        modifier(MatchScore(color:color,backgroundColor: backgroundColor))
    }
    
    func matchScorers(_ color:Color,_ background:Color, _ alignment:Alignment) -> some View {
        modifier(MatchScorers(color:color,backgroundColor:background,alignment:alignment))
    }
}
