//
//  ResultsPresenterTest.swift
//  QuizforAppTests
//
//  Created by Dmitriy Voronin on 03.07.2023.
//

import Foundation
import XCTest
@testable import QuizforEngine
@testable import QuizforApp

class ResultsPresenterTest: XCTestCase {
    func test_summary_withTwoQuestionsAndScoreOne_returnsSummary() {
        // given (Arrange)
        let answers = [Question.singleAnswer("Q1"): ["A1"], Question.multipleAnswer("Q2"): ["A2", "A3"]]
        let result = QuizResult(answers: answers, score: 1)
        let sut = ResultsPresenter(result: result, correctAnswers: [:])
        // when (Act)

        // then (Assert)
        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }

    func test_presentableAnswers_withoutQuestions_isEmpty() {

        let answers = [Question<String>: [String]]()
        let result = QuizResult(answers: answers, score: 1)
        let sut = ResultsPresenter(result: result, correctAnswers: [:])

        XCTAssertTrue(sut.presentableAnswers.isEmpty)
    }

    func test_presentableAnswers_withWrongSingleAnswer_mapsAnswer() {
        let answers = [Question.singleAnswer("Q1"): ["A1"]]
        let correctAnswers = [Question.singleAnswer("Q1"): ["A2"]]
        let result = QuizResult(answers: answers, score: 0)

        let sut = ResultsPresenter(result: result, correctAnswers: correctAnswers)

        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first?.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first?.answer, "A2")
        XCTAssertEqual(sut.presentableAnswers.first?.wrongAnswer, "A1")
   }

    func test_presentableAnswers_withWrongMultipleAnswers_mapsAnswer() {
        let answers = [Question.multipleAnswer("Q1"): ["A1", "A4"]]
        let correctAnswers = [Question.multipleAnswer("Q1"): ["A2", "A3"]]
        let result = QuizResult(answers: answers, score: 0)

        let sut = ResultsPresenter(result: result, correctAnswers: correctAnswers)

        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first?.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first?.answer, "A2, A3")
        XCTAssertEqual(sut.presentableAnswers.first?.wrongAnswer, "A1, A4")
   }

    func test_presentableAnswers_withRightSingleAnswer_mapsAnswer() {
        let answers = [Question.singleAnswer("Q1"): ["A1"]]
        let correctAnswers = [Question.singleAnswer("Q1"): ["A1"]]
        let result = QuizResult(answers: answers, score: 1)

        let sut = ResultsPresenter(result: result, correctAnswers: correctAnswers)

        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first?.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first?.answer, "A1")
        XCTAssertNil(sut.presentableAnswers.first?.wrongAnswer)
   }

    func test_presentableAnswers_withRightMultipleAnswers_mapsAnswer() {
        let answers = [Question.multipleAnswer("Q1"): ["A1", "A4"]]
        let correctAnswers = [Question.multipleAnswer("Q1"): ["A1", "A4"]]
        let result = QuizResult(answers: answers, score: 0)

        let sut = ResultsPresenter(result: result, correctAnswers: correctAnswers)

        XCTAssertEqual(sut.presentableAnswers.count, 1)
        XCTAssertEqual(sut.presentableAnswers.first?.question, "Q1")
        XCTAssertEqual(sut.presentableAnswers.first?.answer, "A1, A4")
        XCTAssertNil(sut.presentableAnswers.first?.wrongAnswer)
   }
}
