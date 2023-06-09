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
    
    func addGrade(_ info: String) throws {
        guard try validateAddSubjectInfoForm(info) else { return }
        
        guard let newInfo = getSubject(info) else { return }
        
        let studentName = newInfo.0
        let newSubject = newInfo.1
        
        guard students.map(\.name).contains(studentName) == true else {
            throw InputError.wrongInfoInput
        }
        
        if isExistingGrade(studentName, newSubject.name) == false {
            appendNewGrade(studentName: studentName, newSubject)
        } else {
            renewGrade(studentName: studentName, newSubject)
        }
    }
    
    private func getSubject(_ info: String) -> (String, Subject)? {
        var subjectInfo = info.split(separator: " ").map { String($0) }
        let studentName = subjectInfo.removeFirst()
        let score = subjectInfo.removeLast()
        
        guard let subjectCredit = Subject.changeCreditToScore(credit: score),
              let subjectName = subjectInfo.first else { return nil}
        
        let newSubject = Subject(
            name: subjectName,
            score: subjectCredit
        )
        
        return (studentName, newSubject)
    }
    
    private func isExistingGrade(_ studentName: String, _ subjectName: String) -> Bool {
        return students
            .first(where: { $0.name == studentName })?.subjects
            .map(\.name)
            .contains(subjectName) ?? false
    }
    
    private func appendNewGrade(studentName: String, _ newSubject: Subject) {
        students.first(where: { $0.name == studentName })?.subjects.append(newSubject)
    }
    
    private func renewGrade(studentName: String, _ newSubject: Subject) {
        guard let subjectIndex = students.first(where: { $0.name == studentName })
            .map(\.subjects)?.firstIndex(where: { $0.name == newSubject.name }) else { return }
        
        students.first(where: { $0.name == studentName })?.subjects[subjectIndex] = newSubject
    }
    
    func removeGrade(_ info: String) {
        
    }
    
    func getAverageCredit(_ name: String) {

    }
    
    func validateAddSubjectInfoForm(_ info: String) throws -> Bool {
        let subjectInfo = info.split(separator: " ").map { String($0) }
        guard subjectInfo.count == 3,
              subjectInfo.isEmpty == false,
              let creditString = subjectInfo.last,
              Subject.changeCreditToScore(credit: creditString) != nil
        else {
            throw InputError.wrongInfoInput
        }
        
        return true
    }
    
    // for Test
    func getStudents() -> [Student] {
        return students
    }
}
