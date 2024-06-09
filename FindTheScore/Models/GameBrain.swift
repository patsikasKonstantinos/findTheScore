//
//  GameBrain.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 17/9/23.
//

import Foundation

class GameBrain{
    //MARK: Properties
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()

    //MARK: Connection Mode
    func setGameConnectionMode(_ mode:ConnectionMode){
        if let encodedData = try? encoder.encode(mode) {
            do {
                try encodedData.write(to: Variables.gameConnectionMode)
            } 
            catch {
                print("Failed to write data to file: \(error)")
            }
        }
    }
    
    func getGameConnectionMode() -> ConnectionMode {
        var mode: ConnectionMode = .offline
        // Read the data from file
        if let savedData = try? Data(contentsOf: Variables.gameConnectionMode) {
            // Decode the data back into a custom object
            if let decodedObject = try? decoder.decode(ConnectionMode.self, from: savedData) {
                mode = decodedObject
            }
        }
        return mode
    }
    
    
    func resetQuestions(){
        let emptyQuestion: [Question] = []
        if let encodedData = try? encoder.encode(emptyQuestion) {
            do {
                try encodedData.write(to: Variables.usedGameQuestionsFileManagereURL)
            } 
            catch {
                print("Failed to write data to file: \(error)")
            }
        }        
    }
    
    func setUsedQuestions(gameQuestion: Question) {
        var existingQuestions: [Question] = []

        // Read existing data from the file
        existingQuestions = getUsedQuestions()

        // Append new game questions to the existing data
        existingQuestions.append(gameQuestion)

        // Encode and write the updated data back to the file
        if let encodedData = try? encoder.encode(existingQuestions) {
            do {
                try encodedData.write(to: Variables.usedGameQuestionsFileManagereURL)
            } catch {
                print("Failed to write data to file: \(error)")
            }
        }
    }
    
    func getUsedQuestions() -> [Question] {
        var questions: [Question] = []
        // Read the data from file
        if let savedData = try? Data(contentsOf: Variables.usedGameQuestionsFileManagereURL) {
            // Decode the data back into a custom object
            if let decodedObject = try? decoder.decode([Question].self, from: savedData) {
                questions = decodedObject
            }
        }
        return questions
    }
    
    
    func setGameQuestionsPerPlayer(players:Int,gameQuestions:[Question]) -> [GamePlayersNumber:[Question]]{
        var lastQuestion:Int = 0
        let questionsNumPerPlayer = gameQuestions.count / players
        var questionsPerPlayer:[GamePlayersNumber:[Question]] = [:]
       
        for i in 0..<players{
            var currPlayer:GamePlayersNumber
            switch i {
                case 0:
                    currPlayer = .player1
                    
                case 1:
                    currPlayer = .player2

                case 2:
                    currPlayer = .player3

                case 3:
                    currPlayer = .player4

                default:
                    currPlayer = .none
            }
            questionsPerPlayer[currPlayer] = []
            
            for x in lastQuestion..<(questionsNumPerPlayer+lastQuestion){
                questionsPerPlayer[currPlayer]?.append(gameQuestions[x])
            }
            
            lastQuestion = questionsNumPerPlayer
        }
        return questionsPerPlayer
    }
    
    func setGameQuestions(players: Int, rounds: Int, leagues: [GameLeagues], 
                          completion: @escaping ((Response?,[GamePlayersNumber:[Question]]?)) -> Void) {
        
        //Initialize
        var gameQuestions:[GamePlayersNumber:[Question]] = [:]

        //Connection Mode
        let connectionMode = getGameConnectionMode()
        
        //Online Mode
        if connectionMode == .online {
            setGameQuestionsOnline(players,rounds,leagues){ serverResponse,questions in
                if serverResponse!.success {
                    gameQuestions = questions ?? [:]
                }
                
                completion((serverResponse,gameQuestions))
            }
        }
        //OfflineMode
        else{
            setGameQuestionsOffLine(players,rounds,leagues){response,questions in
                if response!.success{
                    gameQuestions = questions ?? [:]
                    completion((response,gameQuestions))
                }
            }
        }
 
    }
    
    func setGameQuestionsOnline(_ players:Int,_ rounds:Int,_ leagues:[GameLeagues],
                                completion: @escaping ((Response?,[GamePlayersNumber:[Question]]?)) -> Void) {
        
        var enableSuperLeague:Bool = false
        var enableChampionsLeague:Bool = false
        var enableEuropaLeague:Bool = false
        
        for league in leagues {
            switch league {
                case .greekSuperLeague:
                    enableSuperLeague = true
                
                case .europaLeague:
                    enableEuropaLeague = true
                
                default:
                    enableChampionsLeague = true
            }
        }
        
        var gameQuestions:[Question] = []
        let usedQuestions = getUsedQuestions()
      
        let requiredQuestions = rounds * players

        
        let activeLeagues:[GameLeagues:Bool] = [
            .greekSuperLeague:enableSuperLeague,
            .championsLeague:enableChampionsLeague,
            .europaLeague:enableEuropaLeague
        ]
         
 
        //Change for online
        //Call api
        let apiCallObj:ApiCalls = ApiCalls()
        apiCallObj.callQuestionsApi(leagues:activeLeagues){ response in
             //API Response
            if response!.success {
                let onlineQuestions = response!.questions ?? []
                let totalQuestions = onlineQuestions.count - 1
                let remainQuestions = totalQuestions - usedQuestions.count
        
                if requiredQuestions > remainQuestions {
                    self.resetQuestions()
                }
        
                if onlineQuestions.count >= requiredQuestions {
                    for _ in 1...requiredQuestions {
                        
                        var questionAdded = false
                        while !questionAdded {
                            let randomQuestion = Int.random(in: 0 ... totalQuestions)
                            
                            let currUsedQuestions = self.getUsedQuestions()
                            
                            if onlineQuestions.indices.contains(randomQuestion) {
                                
                                let question = onlineQuestions[randomQuestion]
                                
                                if !currUsedQuestions.contains(where: { $0.id == question.id }) {
                                    gameQuestions.append(question)
                                    //print(gameQuestions)
                                    self.setUsedQuestions(gameQuestion: question)
                                    questionAdded = true
                                }
                            }
                        }
                    }
                }
                //Questions not found
                else{
                    response!.success = false
                }
            }
            
            let serverResponseObj = Response(success: response!.success, message: response!.message,questions: gameQuestions )
            let questionsPerPlayer = self.setGameQuestionsPerPlayer(players: players, gameQuestions: gameQuestions)
            completion((serverResponseObj,questionsPerPlayer))
        }
        
    }
    
    func setGameQuestionsOffLine(_ players:Int,_ rounds:Int,_ leagues:[GameLeagues],
                                 completion: @escaping ((Response?,[GamePlayersNumber:[Question]]?)) -> Void) {
        var leaguesChar:[String] = []
        var message = "Success"
        var success = true

        for league in leagues {
            switch league {
                case .greekSuperLeague:
                    leaguesChar.append("sl")
                    
                
                case .europaLeague:
                    leaguesChar.append("el")
 
                default:
                    leaguesChar.append("ch")
             }

        }
        
        var gameQuestions:[Question] = []
        var fileName:String
        let usedQuestions = getUsedQuestions()
        let totalQuestions = Variables.totalQuestions // change for online
        let remainQuestions = totalQuestions - usedQuestions.count
        let requiredQuestions = rounds * players

        if requiredQuestions > remainQuestions {
           resetQuestions()
        }
         
        for _ in 1...requiredQuestions{
            
            var questionAdded = false
          
            while !questionAdded {
                let randomLeagueIndex = Int.random(in: 0 ..< leaguesChar.count)
                let randomLeagueChar = leaguesChar[randomLeagueIndex]
                let randomQuestion = Int.random(in: 1 ... totalQuestions)
                fileName = "\(randomLeagueChar)_\(randomQuestion)"
                do {
                    let currUsedQuestions = getUsedQuestions()

                    if let bundlePath = Bundle.main.path(forResource: fileName,
                                                         ofType: "json"),
                        let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                        if let question = parseQuestion(json: jsonData,fileName:fileName) {
                            
                            if !currUsedQuestions.contains(where: { $0.id == question.id }) {
                                gameQuestions.append(question)
                                setUsedQuestions(gameQuestion: question)
                                questionAdded = true
                            }
                        }
                    }
                }
                catch {
                    message = "\(error)"
                    success = false
                }
            }
        }
        let responseObj = Response(success: success, message: message,questions: gameQuestions)
        let questionsPerPlayer = setGameQuestionsPerPlayer(players: players, gameQuestions: gameQuestions)
        completion((responseObj,questionsPerPlayer))
    }
    
    func parseQuestion(json x: Data, fileName: String) -> Question? {
        if let jsonPetitions = try? decoder.decode(Questions.self, from: x) {
            if let question = jsonPetitions.questions.first {
                return question
            }
        }
        
        return nil
    }

}
