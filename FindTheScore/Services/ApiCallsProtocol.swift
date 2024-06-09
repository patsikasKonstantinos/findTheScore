//
//  ApiCallsProtocol.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 23/3/24.
//

import Foundation

protocol ApiCallsProtocol {
    
    //MARK: All Api Calls
    func callQuestionsApi(leagues:[GameLeagues:Bool],completion: @escaping (Response?) -> Void)
   
}
