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
}