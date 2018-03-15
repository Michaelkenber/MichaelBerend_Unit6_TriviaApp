//
//  QuestionData.swift
//  triviaApp
//
//  Created by Michael Berend on 12/03/2018.
//  Copyright © 2018 Michael Berend. All rights reserved.
//

import Foundation

// define a struct for the questions
struct Question: Codable {
    var id: Int
    var answer: String
    var question: String
    var difficulty: Int?

    
    // define keys
    enum CodingKeys: String, CodingKey {
        case id
        case answer
        case question
        case difficulty = "value"
        
    }
}

