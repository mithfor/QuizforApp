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
        let sut = ResultsPresenter(result: result)
        // when (Act)

        // then (Assert)
        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }
}
