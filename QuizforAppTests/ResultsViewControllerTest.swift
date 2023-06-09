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
        XCTAssertEqual(makeSUT(answers: [makeDummyAnswer()]).tableView.numberOfRows(inSection: 0), 1)
    }

    func test_viewDidLoad_withCorrectAnswer_renderCorrectAnswerCell() {

        let sut = makeSUT(answers: [PresentableAnswer(isCorrect: true)])
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell

        XCTAssertNotNil(cell)
    }

    func test_viewDidLoad_withWrongAnswer_renderWrongAnswerCell() {

        let sut = makeSUT(answers: [PresentableAnswer(isCorrect: false)])
        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell

        XCTAssertNotNil(cell)
    }

    // MARK: - Helpers

    func makeSUT(summary: String = "", answers: [PresentableAnswer] = []) -> ResultsViewController {
        let sut = ResultsViewController(summary: summary, answers: answers)
        _ = sut.view
        return sut
    }

    func makeDummyAnswer() -> PresentableAnswer {
        return PresentableAnswer(isCorrect: false)
    }
}
