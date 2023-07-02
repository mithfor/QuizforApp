//
//  IOSViewControllerFactoryTest.swift
//  QuizforAppTests
//
//  Created by Dmitriy Voronin on 30.06.2023.
//

import Foundation
import XCTest
@testable import QuizforApp

class IOSViewControllerFactoryTest: XCTestCase {

    func test_questionViewController_createsControllerWithQuestion() {

        let question = Question.singleAnswer("Q1")
        let options = ["A1", "A2"]
        let sut = IOSViewControllerFactory(options: [question: options])

        let controller = sut.questionViewController(for: Question.singleAnswer("Q1"), answerCallback: { _ in }) as? QuestionViewControler

        XCTAssertEqual(controller?.question, "Q1")
    }

    func test_questionViewController_createControllerWithOptions() {

        // given (Arrange)
        let question = Question.singleAnswer("Q1")
        let options = ["A1", "A2"]
        let sut = IOSViewControllerFactory(options: [question: options])

        // when (Act)
        let controller = sut.questionViewController(for: question, answerCallback: {_ in }) as? QuestionViewControler

        // then (Assert)
        XCTAssertEqual(controller?.options, options)
    }
}
