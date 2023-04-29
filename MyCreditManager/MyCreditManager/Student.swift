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
    
    init(name: String) {
        self.name = name
    }
}
