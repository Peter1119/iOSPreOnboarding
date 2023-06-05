//
//  StudentCreditManager.swift
//  MyCreditManager
//
//  Created by Sh Hong on 2023/04/29.
//

import Foundation

protocol StudentCreditManagerProtocol {
    func addStudent(_ name: String) throws
    func removeStudent(_ name: String) throws
    func addGrade(_ info: String) throws
    func removeGrade(_ info: String) throws
    func getAverageCredit(_ name: String) throws
}

class StudentCreditManager: StudentCreditManagerProtocol {
    private var students: [Student] = []
    
    func addStudent(_ name: String) throws {
        try validateName(name)
        
        let newStudent = Student(name: name)
        students.append(newStudent)
    }
    
    func removeStudent(_ name: String) throws {
        try validateName(name)
        
        guard students.map(\.name).contains(name) else {
            throw InputError.existingStudent
        }
        
        students.removeAll {
            $0.name == name
        }
    }
    
    func addGrade(_ info: String) throws {
        let data: [String] = info.split(separator: " ").map { String($0) }
        guard data.count == 3,
              let name = data.first,
              students.map(\.name).contains(name),
              let creditString = data.last,
              let credit = Subject.changeCreditToScore(credit: creditString)
        else { throw InputError.invalidInput }
        
        let subjectName = data[1]
        let subject = Subject(name: subjectName, score: credit)
        
        guard
            let studentIndex = students.map(\.name).firstIndex(of: name),
            let subjectIndex = students[studentIndex]
                .subjects.map(\.name)
                .firstIndex(of: subjectName) else { throw InputError.invalidInput }
        
        students[studentIndex].subjects[subjectIndex] = subject
    }
    
    func removeGrade(_ info: String) throws {
        let data: [String] = info.split(separator: " ").map { String($0) }
        guard data.count == 2,
              let name = data.first,
              students.map(\.name).contains(name),
              let creditString = data.last
        else { throw InputError.invalidInput }
        
        guard let studentIndex = students.map(\.name).firstIndex(of: name),
              let subjectIndex = students[studentIndex].subjects.map(\.name).firstIndex(of: creditString)
        else { throw InputError.invalidInput }
        
        students[studentIndex].subjects.remove(at: subjectIndex)
    }
    
    func getAverageCredit(_ name: String) throws {
        try validateName(name)
    }
    
    private func validateName(_ name: String) throws {
        guard !(name.contains(" ") || name.isEmpty) else {
            throw InputError.wrongValue
        }
    }
    
}
