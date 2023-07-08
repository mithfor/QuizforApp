//
//  IOSViewControllerFactoryTest.swift
//  QuizforAppTests
//
//  Created by Dmitriy Voronin on 30.06.2023.
//

import UIKit
import XCTest
@testable import QuizforApp
@testable import QuizforEngine

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

    func test_resultViewController_createsControllerWithTitle() {

        let results = makeResults()
        XCTAssertEqual(results.controller.title,
                       results.presenter.title)
    }

    func test_resultViewController_createsControllerWithSummary() {

        let results = makeResults()
        XCTAssertEqual(results.controller.summary.count,
                       results.presenter.summary.count)
    }



    func test_resultViewController_createsControllerWithPresentableAnswers() {

        let results = makeResults()
        XCTAssertEqual(results.controller.answers.count,
                       results.presenter.presentableAnswers.count)
    }

    // MARK: - Helpers

    func makeSUT(options: [Question<String>: [String]] = [:], correctAnswers: [Question<String>: [String]] = [:]) -> IOSViewControllerFactory {
        return IOSViewControllerFactory(questions: [singleAnswerQuestion, multipleAnswerQuestion], options: options, correctAnswers: correctAnswers)
    }

    func makeSUT(options: [Question<String>: [String]] = [:], correctAnswers: [(Question<String>, [String])] = []) -> IOSViewControllerFactory {
        return IOSViewControllerFactory(options: options, correctAnswers: correctAnswers)
    }

    func makeQuestionController(question: Question<String> = .singleAnswer("")) -> QuestionViewControler {
        return makeSUT(options: [question: options], correctAnswers: [:]).questionViewController(for: question,
                                      answerCallback: {_ in }) as! QuestionViewControler
    }

    func makeResults() -> (controller: ResultsViewController, presenter: ResultsPresenter) {
        let userAnswers = [(singleAnswerQuestion, ["A1"]), (multipleAnswerQuestion, ["A1, A2"])]
        let correctAnswers = [(singleAnswerQuestion, ["A1"]), (multipleAnswerQuestion, ["A1, A2"])]
        let result = Result(answers: [singleAnswerQuestion: ["A1"], multipleAnswerQuestion: ["A1, A2"]], score: 2)

        let presenter = ResultsPresenter(
            userAnswers: userAnswers,
            correctAnswers: correctAnswers,
            scorer: { _, _ in result.score})

        let sut = makeSUT(correctAnswers: correctAnswers)

        let controller = sut.resultViewController(for: result) as! ResultsViewController

        return (controller, presenter)
    }

}

// swiftlint:enable all
