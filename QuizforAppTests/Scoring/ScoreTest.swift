//
//  ScoreTest.swift
//  QuizforEngineTests
//
//  Created by Dmitriy Voronin on 08.07.2023.
//

import Foundation
import XCTest

class ScoreTest: XCTestCase {

    func test_noAnswers_scoresZero() {
        XCTAssertEqual(BasicScore.score(for: [], comparingTo: []), 0)
    }

    func test_oneNonMatchingAnswer_scoresZero() {
        XCTAssertEqual(BasicScore.score(for: ["not a match"], comparingTo: ["correct"]), 0)
    }

    func test_oneMatchingAnswer_scoresOne() {

        XCTAssertEqual(BasicScore.score(for: ["correct"], comparingTo: ["correct"]), 1)
    }

    func test_oneMatchingAnswerOneWrong_scoresOne() {

        let score = BasicScore.score(for: ["an answer", "not a match"],
                                     comparingTo: ["an answer", "another answer"])
        XCTAssertEqual(score, 1)
    }

    func test_twoMatchingAnswers_scoresTwo() {

        let score = BasicScore.score(for: ["an answer", "another answer"],
                                     comparingTo: ["an answer", "another answer"])
        XCTAssertEqual(score, 2)
    }

    func test_withTooManyAnswers_twoMatchingAnswers_scoresTwo() {
        let score = BasicScore.score(for: ["an answer", "another answer", "an extra answer"],
                                     comparingTo: ["an answer", "another answer"])
        XCTAssertEqual(score, 2)
    }

    func test_withTooManyCorrectAnswers_oneMatchingAnswers_scoresOne() {
        let score = BasicScore.score(for: ["not matching", "another answer"],
                                     comparingTo: ["an answer", "another answer", "an extra answer"])
        XCTAssertEqual(score, 1)
    }

    private class BasicScore {
        static func score(for answers: [String], comparingTo correctAnswers: [String]) -> Int {

            return zip(answers, correctAnswers).reduce(0) { score, tuple in
                return score + (tuple.0 == tuple.1 ? 1 : 0)
            }
        }
    }
}
