//
//  GameQuestions.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 17/9/23.
//

import Foundation

struct Question: Codable {
    var id: Int
    var title: String
    var score: String
    var imgUrl: String
    var text: String
    var category: String
    var extraPoints: Int
    var scorers: [String]
}
 
struct Questions: Codable {
    var questions: [Question]
}
