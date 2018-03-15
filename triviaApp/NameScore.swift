//
//  NamesScores.swift
//  triviaApp
//
//  Created by Michael Berend on 15/03/2018.
//  Copyright © 2018 Michael Berend. All rights reserved.
//

import Foundation

/// a struct to hod names and scores and compare them
struct NameScore: Equatable, Comparable  {
    static var shared = NameScore()
    static var sharedArray = [NameScore]()
    
    var name: String?
    var score: Int = 0
    
    static func ==(lhs: NameScore, rhs: NameScore) -> Bool {
        return lhs.name == rhs.name && lhs.score == rhs.score
    }
    
    static func < (lhs: NameScore, rhs: NameScore) -> Bool {
        return lhs.score < rhs.score
    }
    




}


