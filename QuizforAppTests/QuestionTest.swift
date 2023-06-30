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
        let sut = Question.multipleAnswer(type)

        XCTAssertEqual(sut.hashValue, type.hashValue)
    }

    func test_equal_singleAnswer_isEqual() {
        XCTAssertEqual(Question.singleAnswer("a string"), Question.singleAnswer("a string"))
    }

    func test_notEqual_singleAnswer_isNotEqual() {
        XCTAssertNotEqual(Question.singleAnswer("a string"), Question.singleAnswer("another string"))
    }

    func test_equal_multipleAnswer_isEqual() {
        XCTAssertEqual(Question.multipleAnswer("a string"), Question.multipleAnswer("a string"))
    }

    func test_notEqual_multipleAnswer_isNotEqual() {
        XCTAssertNotEqual(Question.multipleAnswer("a string"), Question.multipleAnswer("another string"))
    }
}
