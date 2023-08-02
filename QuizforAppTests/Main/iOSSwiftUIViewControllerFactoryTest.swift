//
//  iOSSwiftUIViewControllerFactoryTest.swift
//  QuizforAppTests
//
//  Created by Dmitriy Voronin on 01.08.2023.
//

import SwiftUI
import UIKit
import XCTest
@testable import QuizforApp
@testable import QuizforEngine

// swiftlint:disable all
class iOSSwiftUIViewControllerFactoryTest: XCTestCase {

    func test_questionViewController_singleAnswer_createsControllerWithTitle() throws {

        let presenter = QuestionPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion], question: singleAnswerQuestion)
        let view = try XCTUnwrap(makeSingleAnswerQuestion())
        XCTAssertEqual(view.title,
                       presenter.title)
    }

    func test_questionViewController_singleAnswer_createsControllerWithQuestion() throws {

        let view = try XCTUnwrap(makeSingleAnswerQuestion())
        XCTAssertEqual(view.question,
                       "Q1")
    }

    func test_questionViewController_singleAnswer_createControllerWithOptions() throws {

        let view = try XCTUnwrap(makeSingleAnswerQuestion())
        XCTAssertEqual(view.options,
                       options[singleAnswerQuestion ])
    }

    func test_questionViewController_singleAnswer_createControllerWithAnswerCallback() throws {
        var answers = [[String]]()
        let view = try XCTUnwrap(makeSingleAnswerQuestion(answerCallback: { answers.append($0) }))
        XCTAssertEqual(answers,
                       [])

        view.selection(view.options[0])
        XCTAssertEqual(answers,
                       [[view.options[0]]])

        view.selection(view.options[1])
        XCTAssertEqual(answers,
                       [[view.options[0]], [view.options[1]]])

    }

    func test_questionViewController_multipleAnswer_createsControllerWithTitle() throws {

        let presenter = QuestionPresenter(questions: [singleAnswerQuestion,
                                                      multipleAnswerQuestion],
                                          question: multipleAnswerQuestion)

        let view = try XCTUnwrap(makeMultipleAnswerQuestion())


        XCTAssertEqual(view.title,
                       presenter.title)
    }

    func test_questionViewController_multipleAnswer_createsControllerWithQuestion() throws {
        let view = try XCTUnwrap(makeMultipleAnswerQuestion())

        XCTAssertEqual(view.question, "Q2")
    }

    func test_questionViewController_multipleAnswer_createControllerWithOptions() throws {

        let view = try XCTUnwrap(makeMultipleAnswerQuestion())

        XCTAssertEqual(view.store.options.map(\.text), options[multipleAnswerQuestion])
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

    private var singleAnswerQuestion: Question<String> { .singleAnswer("Q1")}

    private var multipleAnswerQuestion: Question<String> { .multipleAnswer("Q2")}

    private var questions: [Question<String>] {
        [singleAnswerQuestion, multipleAnswerQuestion]
    }

    private var options: [Question<String>: [String]] {
        [singleAnswerQuestion: ["A1", "A2", "A3"], multipleAnswerQuestion: ["A4", "A5", "A6"]]
    }

    private var correctAnswers: [(Question<String>, [String])] {
        [(singleAnswerQuestion, ["A1"]), (multipleAnswerQuestion, ["A4", "A5"])]
    }


    func makeSUT() -> iOSSwiftUIViewControllerFactory {
        return iOSSwiftUIViewControllerFactory(options: options, correctAnswers: correctAnswers)
    }

    private func makeSingleAnswerQuestion(
        answerCallback: @escaping ([String]) -> Void = { _ in }
    ) -> SingleAnswerQuestion? {
        let sut = makeSUT()
        let controller = sut.questionViewController(
            for: singleAnswerQuestion,
            answerCallback: answerCallback
        ) as? UIHostingController<SingleAnswerQuestion>
        return controller?.rootView
    }

    func makeMultipleAnswerQuestion(answerCallback: @escaping ([String]) -> Void = { _ in }) -> MultipleAnswerQuestion? {
        let sut = makeSUT()
        let controller = sut.questionViewController(for: multipleAnswerQuestion,
                                                    answerCallback: {_ in }
        ) as? UIHostingController<MultipleAnswerQuestion>
        return controller?.rootView
    }

    func makeResults() -> (controller: ResultsViewController, presenter: ResultsPresenter) {
        let userAnswers = [(singleAnswerQuestion, ["A1"]), (multipleAnswerQuestion, ["A1, A2"])]
        let correctAnswers = [(singleAnswerQuestion, ["A1"]), (multipleAnswerQuestion, ["A1, A2"])]
        let presenter = ResultsPresenter(
            userAnswers: userAnswers,
            correctAnswers: correctAnswers,
            scorer: BasicScore.score)

        let sut = makeSUT()

        let controller = sut.resultsViewController(for: userAnswers) as! ResultsViewController

        return (controller, presenter)
    }

}

// swiftlint:enable all

