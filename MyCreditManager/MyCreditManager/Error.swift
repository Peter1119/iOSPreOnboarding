//
//  Error.swift
//  MyCreditManager
//
//  Created by Sh Hong on 2023/04/29.
//

import Foundation

enum InputError: Error, CustomDebugStringConvertible {
    case invalidInput
    case wrongValue
    case existingStudent
    case invalidStudentName
    case endProgram
    
    var debugDescription: String {
        switch self {
        case .invalidInput:
            return "이미 존재합니다"
        case .wrongValue:
            return "이미 존재합니다"
        case .existingStudent:
            return "이미 존재합니다"
        case .invalidStudentName:
            return "이미 존재합니다"
        case .endProgram:
            return "이미 존재합니다"
        }
    }
}
