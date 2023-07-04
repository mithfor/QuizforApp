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

    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.multipleAnswer("Q2")

    func test_questionViewController_singleAnswer_createsControllerWithTitle() {

        let presenter = QuestionPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion], question: singleAnswerQuestion)
        XCTAssertEqual(makeQuestionController(question: singleAnswerQuestion).title,
                       presenter.title)
    }

    func test_questionViewController_singleAnswer_createsControllerWithQuestion() {

        XCTAssertEqual(makeQuestionController(question: singleAnswerQuestion).question,
                       "Q1")
    }

    func test_questionViewController_singleAnswer_createControllerWithOptions() {


        XCTAssertEqual(makeQuestionController(question: singleAnswerQuestion).options,
                       options)
    }

    func test_questionViewController_singleAnswer_createControllerWithSingleSelection() {
        XCTAssertFalse(makeQuestionController(question: singleAnswerQuestion).allowsMultipleSelection)
    }

    func test_questionViewController_multipleAnswer_createsControllerWithTitle() {

        let presenter = QuestionPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion], question: multipleAnswerQuestion)
        XCTAssertEqual(makeQuestionController(question: multipleAnswerQuestion).title,
                       presenter.title)
    }

    func test_questionViewController_multipleAnswer_createsControllerWithQuestion() {

        XCTAssertEqual(makeQuestionController(question: multipleAnswerQuestion).question, "Q2")
    }

    func test_questionViewController_multipleAnswer_createControllerWithOptions() {

        let controller = makeQuestionController(question: multipleAnswerQuestion)

        XCTAssertEqual(controller.options, options)
    }

    func test_questionViewController_multipleAnswer_createControllerWithMultipleSelection() {

        XCTAssertTrue(makeQuestionController(question: multipleAnswerQuestion).allowsMultipleSelection)
    }



    // MARK: - Helpers

    func makeSUT(options: [Question<String>: [String]]) -> IOSViewControllerFactory {
        return IOSViewControllerFactory(questions: [singleAnswerQuestion, multipleAnswerQuestion], options: options)
    }

    func makeQuestionController(question: Question<String> = .singleAnswer("")) -> QuestionViewControler {
        return makeSUT(options: [question: options]).questionViewController(for: question,
                                      answerCallback: {_ in }) as! QuestionViewControler
    }
}

// swiftlint:enable all
