//
//  QuestionViewControlerTest.swift
//  QuizforAppTests
//
//  Created by Dmitrii Voronin on 18.05.2023.
//

import Foundation
import XCTest
@testable import QuizforApp

class QuestionViewControlerTest: XCTestCase {
    func test_viewDidLoad_rendersQuestionHeaderText() {
        let sut = QuestionViewControler(question: "Q1", options: [])
        _ = sut.view
        XCTAssertEqual(sut.headerLabel.text, "Q1")
    }
    
    func test_viewDidLoad_withNoOptions_rendersZeroOptions() {
        let sut = QuestionViewControler(question: "Q1", options: [])
        _ = sut.view
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    
    func test_viewDidLoad_withOneOption_rendersOneOption() {
        let sut = QuestionViewControler(question: "Q1", options: ["A1"])
        _ = sut.view
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    func test_viewDidLoad_withOneOption_rendersOneOptionText() {
        let sut = QuestionViewControler(question: "Q1", options: ["A1"])
        _ = sut.view
        
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath)
//        XCTAssertEqual(cell?.defaultContentConfiguration().text, "A1")
        XCTAssertEqual(cell?.textLabel?.text, "A1")
    }
}
