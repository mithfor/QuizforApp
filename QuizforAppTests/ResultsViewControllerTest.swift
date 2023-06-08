//
//  ResultsViewControllerTest.swift
//  QuizforAppTests
//
//  Created by Dmitriy Voronin on 09.06.2023.
//

import XCTest
@testable import QuizforApp

final class ResultsViewControllerTest: XCTestCase {

    func test_viewDidLoad_renderSummary() {
        let sut =  makeSUT(summary: "a summary")

        XCTAssertEqual(sut.headerLabel.text, "a summary")
    }

    func test_viewDidLoad_renderAnswers() {

        XCTAssertEqual(makeSUT(answers: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(answers: ["A1"]).tableView.numberOfRows(inSection: 0), 1)
    }

    // MARK: - Helpers

    func makeSUT(summary: String = "", answers: [String] = []) -> ResultsViewController {
        let sut = ResultsViewController(summary: summary, answers: answers)
        _ = sut.view
        return sut
    }
}
