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
    func addGrade(_ info: String)
    func removeGrade(_ info: String)
    func getAverageCredit(_ name: String)
}

class StudentCreditManager: StudentCreditManagerProtocol {
    private var students: [Student] = []
    
    func addStudent(_ name: String) throws {
        guard name.isEmpty == false else {
            throw InputError.emptyString
        }
        guard students.map(\.name).contains(name) == false else {
            throw InputError.alreadyHaveStudent(name: name)
        }
        
        let newStudent = Student(name: name)
        students.append(newStudent)
    }
    
    func removeStudent(_ name: String) throws {
        guard name.isEmpty == false else {
            throw InputError.emptyString
        }
        guard students.map(\.name).contains(name) == true else {
            throw InputError.notExistingStudent(name: name)
        }
        students.removeAll { $0.name == name }
    }
    
    func addGrade(_ info: String) {
        
    }
    
    func removeGrade(_ info: String) {
        
    }
    
    func getAverageCredit(_ name: String) {
        
    }
    
    func validateSubjectInfoForm(_ info: String) throws -> Bool {
        guard info.isEmpty == false else {
            throw InputError.wrongInfoInput
        }
        let subjectInfo = info.split(separator: " ").map { String($0) }
        guard subjectInfo.count == 3 else {
            throw InputError.wrongInfoInput
        }
        
        guard let creditString = subjectInfo.last,
            Subject.changeCreditToScore(credit: creditString) != nil else {
            throw InputError.wrongInfoInput
        }
        
        return true
    }
    
    // for Test
    func getStudents() -> [Student] {
        return students
    }
}
