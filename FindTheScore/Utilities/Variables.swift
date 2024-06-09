//
//  Variables.swift
//  FindTheScore
//
//  Created by Κωνσταντίνος Πατσίκας on 15/9/23.
//

import Foundation

class Variables {
    
    static let introTextScreen1:String = "Σκοπός του παιχνιδιού είναι να μαζέψετε όσο το δυνατόν περισσότερους πόντους βρίσκοντας τα σκορ και τους σκόρερς του εκάστοτε αγώνα.\nΕπιλέξτε από την αρχική οθόνη τα πρωταθλήματα που θέλετε να συμμετέχουν στο παιχνίδι ,το χρόνο παιχνιδιού καθώς και τον αριθμό των γύρων.\nΣε κάθε γύρο παιχνιδιού ένας από τους παίκτες του οποίου δεν είναι η σειρά να παίξει, αναλαμβάνει να εκφωνήσει τον αγώνα της κάρτας που εμφανίζεται στην οθόνη.\n Κάθε φορά που ένας παίκτης βρίσκει το σωστό σκορ , τότε 10 βαθμοί προστίθονται στους συνολικούς πόντους του.\n Ο παίκτης εκτός από το συνολικό σκορ του αγώνα μπορεί να απαντήσει και τους σκόρερς της αναμέτρησης."
    
    static let introTextScreen2:String = " Για κάθε μια σωστή απάντηση σκόρερ , προστίθονται 5 βαθμοί στους συνολικούς πόντους του παίκτη.\n Από την αρχή του παιχνιδιού πρέπει όλοι οι παίκτες να συμφωνήσουν εάν για να θεωρηθεί σωστή απάντηση ενός σκόρερ απαιτείτε να βρεθεί και το λεπτό του γκολ ή αρκεί το όνομα του παίκτη που το πέτυχε.\nΝικητής είναι ο παίκτης ο οποίος στο τέλος του παιχνιδιού μαζέψει τους περισσότερους πόντους."
    
    static let usedGameQuestionsFileManagereURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("usedGameQuestions")
    
    static let gameConnectionMode = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("gameConnectionMode")

    //Offline total questions
    static let totalQuestions = 170
    
    static let questionsApiUrl = "YOUR_QUESTION_API_URL";
    
}
