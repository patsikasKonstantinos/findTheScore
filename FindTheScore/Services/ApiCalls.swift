//
//  QuestionsApi.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 23/3/24.
//

import Foundation

class ApiCalls:ApiCallsProtocol {
     
    //MARK: Initialization
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    func buildQuestionApiUrl(_ activeLeagues:[GameLeagues:Bool]) -> String {
        
        //Get active leagues
        let greekSuperLeague = activeLeagues[.greekSuperLeague] ?? false
        let championsLeague = activeLeagues[.championsLeague] ?? false
        let europaLeague = activeLeagues[.europaLeague] ?? false
        
        let leaguesArr:[String] = [
            greekSuperLeague ? "1" : "",
            championsLeague ? "2" : "",
            europaLeague ? "3" : "",
        ]
        
        //Filter only not empty values
        var leaguesFilterString = leaguesArr.filter { !$0.isEmpty }.joined(separator: ",")

        if !leaguesFilterString.isEmpty {
            leaguesFilterString = "?leagues=" + leaguesFilterString
        }
        
        return leaguesFilterString
    }
    
    func callQuestionsApi(leagues:[GameLeagues:Bool], completion: @escaping (Response?) -> Void) {
         
        let serverResponseObj = Response(success: false, message: "An error occurred",questions: nil )
        let leaguesFilterString = buildQuestionApiUrl(leagues)
//        print("\(Variables.questionsApiUrl)\(leaguesFilterString)")
        guard let url = URL(string: "\(Variables.questionsApiUrl)\(leaguesFilterString)") else {
            
            serverResponseObj.message = "Invalid URL"
            completion(serverResponseObj)

            return
        }
        
        var request = URLRequest(url: url)
        
        // Set the HTTP method to GET
        request.httpMethod = "GET"
 
        // Set the Content-Type header to application/json
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

          // Create a URLSession instance
        let session = URLSession.shared
          
        // Create a data task using the URL
        let task = session.dataTask(with: request) { (data, response, error) in
              // Check for any errors
              if let error = error {
                  serverResponseObj.message = "Error: \(error.localizedDescription)"
                  completion(serverResponseObj)
                  return
              }
              
              // Ensure that we have received a response
              guard let httpResponse = response as? HTTPURLResponse else {
                  serverResponseObj.message = "Invalid response"
                  completion(serverResponseObj)
                  return
              }
              
              // Check the response status code
              if httpResponse.statusCode == 200 {
                  // Ensure that we have received data
                  guard let jsonData = data else {
                      completion(serverResponseObj)
                      return
                  }
                  do {
                      
                      // Parse the JSON data
                      let myData = try self.decoder.decode(Response.self, from: jsonData)
                      if myData.success {
                          serverResponseObj.success = true
                          serverResponseObj.message = "Success"
                          serverResponseObj.questions = myData.questions
                      }
                      else{
                          serverResponseObj.message = "An error occurred"
                      }
                      completion(serverResponseObj)
                  }
                  catch {
                      serverResponseObj.message = String(describing: error)
                      completion(serverResponseObj)
                  }
              }
              else {
                      serverResponseObj.message = "HTTP Response Error - Status code: \(httpResponse.statusCode)"
                      completion(serverResponseObj)
              }
        }
        // Start the data task
        task.resume()
    }
    
}
