//
//  Score.swift
//  MyCreditManager
//
//  Created by Sh Hong on 2023/04/28.
//

import Foundation

struct Subject: Equatable {
    let name: String
    var score: Double
    
    init(name: String, score: Double) {
        self.score = score
        self.name = name
    }
    
    static func changeCreditToScore(credit: String) -> Double? {
        switch credit {
        case "A+": return 4.5
        case "A": return 4.0
        case "B+": return 3.5
        case "B": return 3.0
        case "C+": return 2.5
        case "C": return 2.0
        case "D+": return 1.5
        case "D": return 1.0
        case "F": return 0.0
        default: return nil
        }
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.name == rhs.name
    }
}
