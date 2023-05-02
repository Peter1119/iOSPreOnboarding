//
//  Studeont.swift
//  MyCreditManager
//
//  Created by Sh Hong on 2023/04/28.
//

import Foundation

class Student: Equatable {
    var name: String
    var subjects: [Subject] = []
    
    init(name: String) {
        self.name = name
    }
}

extension Student {
    static func == (lhs: Student, rhs: Student) -> Bool {
        return lhs.name == rhs.name
    }
}
