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
    func addGrade(_ name: String, subject: Subject) throws
    func removeGrade(_ name: String, subject: Subject) throws
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
        
        if students.map(\.name).contains(name) {
            students.removeAll {
                $0.name == name
            }
        } else {
            throw InputError.existingStudent
        }
    }
    
    func addGrade(_ name: String, subject: Subject) throws {
        try validateName(name)
        
        let student = students.first { $0.name == name }
        
        guard let student else {
            throw InputError.invalidStudentName
        }
        
        if student.subjects.map(\.name).contains(subject.name) {
            
        }

    }
    
    func removeGrade(_ name: String, subject: Subject) throws {
        try validateName(name)
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
