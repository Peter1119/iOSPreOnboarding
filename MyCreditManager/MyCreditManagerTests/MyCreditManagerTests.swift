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
    
    // MARK: - 성적 입력 방식 Validation TEST
    func test_info가띄어쓰기없이empty정보를입력하면에러를방출함() {
        // given
        let info = String()
        
        // when
        XCTAssertThrowsError(try sut.validateSubjectInfoForm(info)) { error in
            
            // then
            XCTAssertEqual(error as? InputError, InputError.wrongInfoInput)
        }
    }
    
    func test_info가띄어쓰기없이1가지정보를입력하면에러를방출함() {
        // given
        let info = "Mike"
        
        // when
        XCTAssertThrowsError(try sut.validateSubjectInfoForm(info)) { error in
            
            // then
            XCTAssertEqual(error as? InputError, InputError.wrongInfoInput)
        }
    }
    
    func test_info가띄어쓰기없이2가지정보를입력하면에러를방출함() {
        // given
        let info = "Mike Swift"
        
        // when
        XCTAssertThrowsError(try sut.validateSubjectInfoForm(info)) { error in
            
            // then
            XCTAssertEqual(error as? InputError, InputError.wrongInfoInput)
        }
    }
    
    func test_info가띄어쓰기없이3가지정보를입력하면true를방출함() {
        // given
        let info = "Mike Swift A+"
        
        // when
        do {
            let result = try sut.validateSubjectInfoForm(info)
            
            // then
            XCTAssertEqual(result, true)
        } catch {
            XCTFail("예상 밖의 오류 발생: \(error)")
        }
    }
    
    func test_성적형태가올바르지않으면에러방출() {
        // given
        let info = "Mike Swift R+"
        
        // when
        XCTAssertThrowsError(try sut.validateSubjectInfoForm(info)) { error in
            
            // then
            XCTAssertEqual(error as? InputError, InputError.wrongInfoInput)
        }
    }
    
    // MARK: - 성적 추가 TEST
    func test_이미존재하는Mike에_Mike_swift_A_성적을입력하면성적이추가됨() {
        // given
        let studentName = "Mike"
        do {
            try sut.addStudent(studentName)
        } catch {
            XCTFail("예상 밖의 오류 발생: \(error)")
        }
        let info = "Mike Swift A"
        
        // when
        do {
            try sut.addGrade(info)
        } catch {
            XCTFail("예상 밖의 오류 발생: \(error)")
        }
        
        let result = sut.getStudents().first { $0.name == studentName }
        
        // then
        XCTAssertEqual(result?.subjects.count, 1)
        XCTAssertEqual(result?.subjects.map(\.name).contains("Swift"), true)
    }
    
    func test_성적이_이미존재할경우에갱신됨() {
        // given
        let studentName = "Mike"
        do {
            try sut.addStudent(studentName)
        } catch {
            XCTFail("예상 밖의 오류 발생: \(error)")
        }
        let info = "Mike Swift A"
        
        do {
            try sut.addGrade(info)
        } catch {
            XCTFail("예상 밖의 오류 발생: \(error)")
        }
        
        // when
        let newInfo = "Mike Swift B+"
        
        do {
            try sut.addGrade(newInfo)
        } catch {
            XCTFail("예상 밖의 오류 발생: \(error)")
        }
        
        let result = sut.getStudents().first { $0.name == studentName }
        
        // then
        XCTAssertEqual(result?.subjects.count, 1)
        XCTAssertEqual(result?.subjects.first(where: { $0.name == "Swift" })?.score, 3.5)
    }
}
