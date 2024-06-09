//
//  Response.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 23/3/24.
//

import Foundation

class Response: Codable {
    var success:Bool
    var message:String?
    var questions:[Question]?
    
    //MARK: Initialization
    init(success: Bool, message: String?, questions: [Question]?) {
        self.success = success
        self.message = message
        self.questions = questions
    }
}
