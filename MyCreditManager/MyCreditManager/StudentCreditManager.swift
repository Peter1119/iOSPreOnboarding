//
//  StudentCreditManager.swift
//  MyCreditManager
//
//  Created by Sh Hong on 2023/04/29.
//

import Foundation

protocol StudentCreditManagerProtocol {
    func addStudent(_ name: String) throws
    func removeStudent(_ name: String)
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
    
    func removeStudent(_ name: String) {
        
    }
    
    func addGrade(_ info: String) {
        
    }
    
    func removeGrade(_ info: String) {
        
    }
    
    func getAverageCredit(_ name: String) {
        
    }
    
    // for Test
    func getStudents() -> [Student] {
        return students
    }
}
