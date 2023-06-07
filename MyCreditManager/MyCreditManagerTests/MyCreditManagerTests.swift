//
//  MyCreditManagerTests.swift
//  MyCreditManagerTests
//
//  Created by Sh Hong on 2023/06/05.
//

import XCTest
@testable import MyCreditManager

final class MyCreditManagerTests: XCTestCase {

    var sut: StudentCreditManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = StudentCreditManager()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func test_Mike이름을넣으면Mike학생이들어가있음() {
        // given
        let studentName = "Mike"
        
        // when
        try! sut.addStudent(studentName)
        let students = sut.getStudents()
        
        // then
        XCTAssertEqual(students.first?.name, studentName)
    }
    
    func test_빈글자가들어가면학생추가가되지않음() {
        // given
        let emptyString = String()
        let initialStudentsCount = sut.getStudents().count
        
        // when
        do {
            try sut.addStudent(emptyString)
        } catch let error as InputError {
            XCTAssertEqual(error, InputError.emptyString)
        } catch {
            XCTFail("예상 밖의 오류 발생: \(error)")
        }
        let result = sut.getStudents().count
        
        // then
        XCTAssertEqual(initialStudentsCount, result)
    }
    
    func test_이미존재하는학생은추가하지않음() {
        // given
        let studentName = "Mike"
        do {
            try sut.addStudent(studentName)
        } catch {
            XCTFail("예상 밖의 오류 발생: \(error)")
        }
        let initialStudentsCount = sut.getStudents().count

        // when
        do {
            try sut.addStudent(studentName)
        } catch let error as InputError {
            XCTAssertEqual(error, InputError.alreadyHaveStudent(name: studentName))
        } catch {
            XCTFail("예상 밖의 오류 발생: \(error)")
        }
        let result = sut.getStudents().count

        // then
        XCTAssertEqual(initialStudentsCount, result)
    }
    
    }
}
