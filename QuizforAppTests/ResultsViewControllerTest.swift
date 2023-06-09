//
//  ResultsViewControllerTest.swift
//  QuizforAppTests
//
//  Created by Dmitriy Voronin on 09.06.2023.
//
import Foundation
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

        let sut = makeSUT(answers: [makeAnswer(isCorrect: true)])

        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell

        XCTAssertNotNil(cell)
    }

    func test_viewDidLoad_withCorrectAnswer_renderQuestionText() {
        let answer = makeAnswer(question: "Q1", isCorrect: true)
        let sut = makeSUT(answers: [answer])
        
        let cell = sut.tableView.cell(at: 0) as! CorrectAnswerCell

        XCTAssertEqual(cell.questionLabel.text, "Q1")
    }

    func test_viewDidLoad_withWrongAnswer_renderWrongAnswerCell() {

        let sut = makeSUT(answers: [makeAnswer(isCorrect: false)])
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
        return makeAnswer(isCorrect: false)
    }

    func makeAnswer(question: String = "", isCorrect: Bool) -> PresentableAnswer {
        return PresentableAnswer(question: question, isCorrect: isCorrect)
    }
}
