//
//  Question.swift
//  QuizforApp
//
//  Created by Dmitriy Voronin on 30.06.2023.
//

import Foundation

enum Question<T: Hashable>: Hashable {
    case singleAnswer(T)
    case multipleAnswer(T)

    func hash(into hasher: inout Hasher) {

        switch self {
        case .singleAnswer(let value):
            hasher.combine(value)

        case .multipleAnswer(let value):
            hasher.combine(value)
        }
    }

    static func == (lhs: Question<T>, rhs: Question<T>) -> Bool {
        switch (lhs, rhs) {
        case ( .singleAnswer(let aValue), .singleAnswer(let bValue) ):
            return aValue == bValue
        case ( .multipleAnswer(let aValue), .multipleAnswer(let bValue) ):
            return aValue == bValue
        default:
            return false
        }
    }
}
