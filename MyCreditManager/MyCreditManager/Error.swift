//
//  Error.swift
//  MyCreditManager
//
//  Created by Sh Hong on 2023/04/29.
//

import Foundation

enum InputError: Error, CustomDebugStringConvertible, Equatable {
    case alreadyHaveStudent(name: String)
    case emptyString
    case notExistingStudent(name: String)
    
    var debugDescription: String {
        switch self {
        case .alreadyHaveStudent(let name):
            return "\(name)은 이미 존재하는 학생입니다. 추가하지 않습니다."
        case .emptyString:
            return "이름을 입력하지 않으셨습니다. 추가하지 않습니다."
        case .notExistingStudent(name: let name):
            return "\(name) 학생을 찾지 못했습니다."
        }
    }
}
