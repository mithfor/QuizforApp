//
//  QuestionTest.swift
//  QuizforAppTests
//
//  Created by Dmitriy Voronin on 30.06.2023.
//

import Foundation
import XCTest
@testable import QuizforApp

class QuestionTest: XCTestCase {

    func test_hashValue_singleAnswer_returnsTypeHash() {

        let type = "a string"
        let sut = Question.singleAnswer(type)

        XCTAssertEqual(sut.hashValue, type.hashValue)
    }

    func test_hashValue_multipleAnswer_returnsTypeHash() {

        let type = "a string"
        let sut = Question.multileAnswer(type)

        XCTAssertEqual(sut.hashValue, type.hashValue)
    }
}
