//
//  Extens.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 3/10/23.
//

import UIKit
import AVFoundation
import SwiftUI

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}

//Some Colors
extension Color {
    static let gold = Color(red: 255 / 255, green: 215 / 255, blue: 0)
    static let blueColor = Color(red:0.39608,green:0.53333,blue:0.66667,opacity: 0.7)

}
