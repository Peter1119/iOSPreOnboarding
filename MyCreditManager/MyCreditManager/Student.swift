//
//  Studeont.swift
//  MyCreditManager
//
//  Created by Sh Hong on 2023/04/28.
//

import Foundation

class Student {
    var name: String
    var subjects: [Subject] = []
    var average: Double {
        return Double(subjects.map(\.score).reduce(0, +)) / Double(subjects.count)
    }
    
    init(name: String) {
        self.name = name
    }
}
