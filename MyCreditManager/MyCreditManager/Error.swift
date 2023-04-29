//
//  Error.swift
//  MyCreditManager
//
//  Created by Sh Hong on 2023/04/29.
//

import Foundation

enum InputError: Error {
    case invalidInput
    case wrongValue
    case existingStudent
    case invalidStudentName
    case endProgram
}
