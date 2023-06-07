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

    // MARK: - 학생 추가 TEST
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
    
    // MARK: - 학생 제거 TEST
    func test_Mike학생추가후_Mike삭제하면_삭제됨() {
        // given
        let studentName = "Mike"
        do {
            try sut.addStudent(studentName)
        } catch {
            XCTFail("예상 밖의 오류 발생: \(error)")
        }
        
        // when
        do {
            try sut.removeStudent(studentName)
        } catch {
            XCTFail("예상 밖의 오류 발생: \(error)")
        }
        
        // then
        XCTAssertEqual(
            sut.getStudents().map(\.name).contains(studentName),
            false
        )
    }
    
    func test_학생제거할때빈글자가들어가면에러발생() {
        // given
        let emptyString = String()
        
        // when
        XCTAssertThrowsError(try sut.removeStudent(emptyString)) { error in
            
            // then
            XCTAssertEqual(error as? InputError, InputError.emptyString)
        }
    }
    
    func test_이미존재하는학생이아닐경우에러발생() {
        // given
        let studentName = "Mickey"

        // when
        XCTAssertThrowsError(try sut.removeStudent(studentName)) { error in
            
            // then
            XCTAssertEqual(error as? InputError, InputError.notExistingStudent(name: studentName))
        }
    }
    
    // MARK: - 성적 추가 TEST
    
}
