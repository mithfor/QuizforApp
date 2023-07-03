//
//  IOSViewControllerFactoryTest.swift
//  QuizforAppTests
//
//  Created by Dmitriy Voronin on 30.06.2023.
//

import UIKit
import XCTest
@testable import QuizforApp

// swiftlint:disable all
class IOSViewControllerFactoryTest: XCTestCase {

    let options = ["A1", "A2"]

    func test_questionViewController_singleAnswer_createsControllerWithTitle() {

        XCTAssertEqual(makeQuestionController(question: Question.singleAnswer("Q1")).title,
                       "Question #1")
    }

    func test_questionViewController_singleAnswer_createsControllerWithQuestion() {

        XCTAssertEqual(makeQuestionController(question: Question.singleAnswer("Q1")).question,
                       "Q1")
    }

    func test_questionViewController_singleAnswer_createControllerWithOptions() {


        XCTAssertEqual(makeQuestionController(question: Question.singleAnswer("Q1")).options,
                       options)
    }

    func test_questionViewController_singleAnswer_createControllerWithSingleSelection() {

        let controller = makeQuestionController(question: Question.singleAnswer("Q1"))
        _ = controller.view

        XCTAssertFalse(controller.tableView.allowsMultipleSelection)
    }

    func test_questionViewController_multipleAnswer_createsControllerWithQuestion() {

        XCTAssertEqual(makeQuestionController(question: Question.multipleAnswer("Q1")).question, "Q1")
    }

    func test_questionViewController_multipleAnswer_createControllerWithOptions() {

        let controller = makeQuestionController(question: Question.multipleAnswer("Q1"))

        XCTAssertEqual(controller.options, options)
    }

    func test_questionViewController_multipleAnswer_createControllerWithMultipleSelection() {

        let controller = makeQuestionController(question: Question.multipleAnswer("Q1"))
        _ = controller.view

        XCTAssertTrue(controller.tableView.allowsMultipleSelection)
    }



    // MARK: - Helpers

    func makeSUT(options: [Question<String>: [String]]) -> IOSViewControllerFactory {
        return IOSViewControllerFactory(options: options)
    }

    func makeQuestionController(question: Question<String> = .singleAnswer("")) -> QuestionViewControler {
        return makeSUT(options: [question: options]).questionViewController(for: question,
                                      answerCallback: {_ in }) as! QuestionViewControler
    }
}

// swiftlint:enable all
