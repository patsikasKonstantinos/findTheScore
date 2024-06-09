//
//  SettingsViewModel.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 15/9/23.
//

import Foundation

class SettingsViewModel:ObservableObject{
    
    //MARK: Properties
    @Published var gamePlayers:GamePlayers = .none
    @Published var gameRounds:GameRounds = .none
    @Published var gameDuration:GameDuration = .none
    @Published var gameLeagues:[GameLeagues] = []
    @Published var playersNames:[GamePlayersNumber:String] = [.player1:"",.player2:"",.player3:"",.player4:""]
    @Published var gameQuestions:[GamePlayersNumber:[Question]] = [:]
    @Published var gamePlayersScore:[GamePlayersNumber:Int] = [.player1:0,.player2:0,.player3:0,.player4:0]
    @Published var currQuestionPoints:Int = 0
    @Published var currGameRound:Int = 1
    @Published var currGamePlayer:GamePlayersNumber = .player1
    @Published var finishGame:Bool = false
    @Published var successScoreSelect:Bool = false
    @Published var successScorerSelect:[Bool] = []
    @Published var gameDraw:Bool = false
    @Published var loadQuestionsLoader:Bool = false
    @Published var showingSettings:Bool = false
    @Published var savedGameConnectionMode:ConnectionMode = .offline

    private let gameBrain:GameBrain = GameBrain()
    let orderedPlayerNumbers: [GamePlayersNumber] = [.player1, .player2, .player3, .player4]

    var currQuestion:Question? {
        if let playerQuestions = gameQuestions[currGamePlayer], !playerQuestions.isEmpty {
            return playerQuestions[0]
        } else {
            // Handle the case where the value is nil or the array is empty
            return nil // or return a default value or handle the error accordingly
        }
    }
        
    var currQuestionScorers:[String] {
        return currQuestion?.scorers ?? []
    }
 
    var currPlayerName:String {
        return playersNames[currGamePlayer]!
    }
    
    var activeNextButtonScreen1:Bool {
        if gameLeagues.count > 0 && gamePlayers != .none {
            return true
        }
        else{
            return false
        }
    }
    
    var activeNextButtonScreen2:Bool {
        for i in 0..<playersCount{
            var currPlayer:GamePlayersNumber = .none
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
            
            if playersNames[currPlayer] == "" {
                return false
            }
        }
        return true
    }
    
    var activeNextButtonScreen3:Bool {
        if gameRounds != .none && gameDuration != .none {
            return true
        }
        else{
            return false
        }
//        return false
    }
    
    var playersCount:Int {
        
        switch gamePlayers {
            
            case .twoPlayers:
                 return 2
                
            case .threePlayers:
                 return 3
                
            case .fourPlayers:
                 return 4
                
            default:
                return 0
        }
    }
    
    var gameDurationSeconds:Int {
        switch gameDuration {
            
            case .thirty:
                 return 30
                
            case .sixty:
                 return 60
                
            case .ninty:
                 return 90
                
            default:
                return 0
        }
    }
    
    var gameRoundsCount:Int {
        switch gameRounds {
            
            case .ten:
                 return 10
                
            case .fifteen:
                 return 15
                
            case .twenty:
                 return 20
                
            default:
                return 0
        }
    }
    
    var currGamePlayerRound:Int{
        if playersCount > 0 {
            return (((gameRoundsCount*playersCount)/playersCount) - (gameQuestions[currGamePlayer]?.count ?? 0)) + 1
        }
        else {
            return 0
        }
     }
    
    var topScore:Int{
        guard let maxScore = topScorers.max(by: { $0.1 < $1.1 }) else {
             return 0
         }
         return maxScore.1
    }
    
    var topScorers: [(GamePlayersNumber, Int)] {
        let sortedScores = gamePlayersScore.sorted { $0.value > $1.value }
        var filteredScores: [(GamePlayersNumber, Int)] = []

        for i in 0..<sortedScores.count {
            let playerName = sortedScores[i].key
            if !playersNames[playerName]!.isEmpty {
                filteredScores.append(sortedScores[i])
            }
        }
        return filteredScores
    }
    
    var winnerName: String {
        guard let maxScoreTuple = gamePlayersScore.max(by: { $0.value < $1.value }) else {
            return ""
        }

        guard let playerName = playersNames[maxScoreTuple.key], !playerName.isEmpty else {
            return ""
        }

        return playerName
    }

    //MARK: Functions
    
    func savedTopScorer() -> String{
        if let savedTopScorer = UserDefaults.standard.value(forKey: "savedTopScorer") as? String {
            // Use the retrieved boolean value
            return savedTopScorer
        } else {
            // The key "isUserLoggedIn" doesn't exist or is not a boolean value
           return ""
        }
    }
    
    func savedTopScore() -> Int{
        if let savedTopScore = UserDefaults.standard.value(forKey: "savedTopScore") as? Int {
            // Use the retrieved boolean value
            return savedTopScore
        } else {
            // The key "isUserLoggedIn" doesn't exist or is not a boolean value
           return 0
        }
    }
    
    func saveTopScore(){
        UserDefaults.standard.set(topScore, forKey: "savedTopScore")
        UserDefaults.standard.set(winnerName, forKey: "savedTopScorer")
    }
    
    
    
    func skipIntro(){
        UserDefaults.standard.set(true, forKey: "skipIntro")
    }
    
    func getSkipIntroBoolean() -> Bool {
        if let skipIntro = UserDefaults.standard.value(forKey: "skipIntro") as? Bool {
            // Use the retrieved boolean value
            return skipIntro
        } else {
            // The key "isUserLoggedIn" doesn't exist or is not a boolean value
           return false
        }
    }
    
    func setGamePlayersScore(_ success:Bool,_ matchScore:Bool){
        if success {
            gamePlayersScore[currGamePlayer]! += matchScore ? 10 : 5
            currQuestionPoints += matchScore ? 10 : 5
        }
        else{
            gamePlayersScore[currGamePlayer]! -= matchScore ? 10 : 5
            currQuestionPoints -= matchScore ? 10 : 5
        }
         
//        print("gamePlayersScore \(gamePlayersScore)")

     }
    
    func splitStrings(_ strings: [String]) -> [[String]] {
        return strings.map { $0.split(separator: "!").map { String($0) } }
    }
    
    func setGameConnectionMode(_ mode:ConnectionMode){
        savedGameConnectionMode = mode
        gameBrain.setGameConnectionMode(mode)
    }
    
    func getGameConnectionMode(){
        savedGameConnectionMode = gameBrain.getGameConnectionMode()
    }
    
    func setGamePlayers(_ players:GamePlayers){
        if gamePlayers == players {
            gamePlayers = .none
            return
        }
        gamePlayers = players
    }
    
    func setGameLeagues(_ league:GameLeagues){
        if gameLeagues.contains(league){
            if let index = gameLeagues.firstIndex(of: league) {
               gameLeagues.remove(at: index)
            }
        }
        else{
            gameLeagues.append(league)
        }
    }
    
    func setGameRounds(_ rounds:GameRounds){
        //If loader is disabled
        if !loadQuestionsLoader {
            if gameRounds == rounds {
                gameRounds = .none
                return
            }
            gameRounds = rounds
        }
    }
    
    func setGameDuration(_ duration:GameDuration){
        //If loader is disabled
        if !loadQuestionsLoader {
            if gameDuration == duration {
                gameDuration = .none
                return
            }
            gameDuration = duration
        }
    }
    
    //MARK: Game Functions
    func convertToIntPlayerNumber(_ player:GamePlayersNumber) -> Int{
        switch player {
            case .player1:
                return 1
                
            case .player2:
                return 2

            case .player3:
                return 3

            case .player4:
                return 4

            default:
                return 1
        }
    }
    
    func setupGame(completion: @escaping (Response?) -> Void){
        setGameQuestions{ systemResponse in
            self.setSuccessScorerSelect()
            completion(systemResponse)
        }
    }
    
    func reset(){
        gamePlayers = .none
        gameRounds = .none
        gameDuration = .none
        gameLeagues = []
        playersNames = [.player1:"",.player2:"",.player3:"",.player4:""]
        gameQuestions = [:]
        gamePlayersScore = [.player1:0,.player2:0,.player3:0,.player4:0]
        currQuestionPoints = 0
        currGameRound = 1
        currGamePlayer = .player1
        finishGame = false
        successScoreSelect = false
        successScorerSelect = []
        gameDraw = false
    }
    
    func setGameQuestions(completion: @escaping (Response?) -> Void){
        gameBrain.setGameQuestions(players:playersCount,rounds:gameRoundsCount,leagues: gameLeagues){
            serverResponse,questions in
            if serverResponse!.success && (questions ?? [:]).count > 0 {
                DispatchQueue.main.async {
                    self.gameQuestions = questions!
                }
            }
            //Dispatch event from main queue
            DispatchQueue.main.async {
                completion(serverResponse)
            }
        }
    }
    
    func setSuccessScorerSelect(){
        for index in 0..<successScorerSelect.count {
            successScorerSelect[index] = false
        }
        
        if currQuestionScorers.count > successScorerSelect.count {
            let diff = currQuestionScorers.count - successScorerSelect.count
            for _ in 0..<diff{
                successScorerSelect.append(false)
            }
        }
 
    }
    
    func endGame(){
        finishGame = true
        var count = 0
        for (_, score) in topScorers {
            if count > 0 && score == topScore {
                gameDraw = true
            }
            count += 1
        }

        if savedTopScore() < topScore {
            saveTopScore()
        }
    }
    
    func checkEndGame(){
        
        var nextPlayer:GamePlayersNumber = currGamePlayer

        switch currGamePlayer {
            case .player1:
                nextPlayer = .player2
                
            case .player2:
            
                if playersNames[.player3] == "" {
                    nextPlayer = .player1
                }
                else{
                    nextPlayer = .player3
                }
                 
            case .player3:
                if playersNames[.player4] == "" {
                    nextPlayer = .player1
                }
                else{
                    nextPlayer = .player4
                }

            case .player4:
                nextPlayer = .player1

            default:
                nextPlayer = .player1
        }
                
        //Finish Game
        if let playerQuestions = gameQuestions[nextPlayer], playerQuestions.isEmpty {
            endGame()
        }
    }
    
    func nextPlayer(){
        successScoreSelect = false
        currQuestionPoints = 0
//        print(gameQuestions)
        //Finish Game
        currGameRound = currGameRound + 1
 
        if let playerQuestions = gameQuestions[currGamePlayer], !playerQuestions.isEmpty {
            gameQuestions[currGamePlayer]?.remove(at: 0)
            setSuccessScorerSelect()
        }
        
 
        switch currGamePlayer {

            case .player1:
                currGamePlayer = .player2
                
            case .player2:
            
                if playersNames[.player3] == "" {
                    currGamePlayer = .player1
                }
                else{
                    currGamePlayer = .player3
                }
                 
            case .player3:
            
                if playersNames[.player4] == "" {
                    currGamePlayer = .player1
                }
                else{
                    currGamePlayer = .player4
                }

            case .player4:
                currGamePlayer = .player1

            default:
                currGamePlayer = .player1
        }
              
     }
}
