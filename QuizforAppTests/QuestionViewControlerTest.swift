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

        XCTAssertEqual(makeSUT(question: "Q1").headerLabel.text, "Q1")
    }
    
    func test_viewDidLoad_rendersOptions() {
        XCTAssertEqual(makeSUT(options: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(options: ["A1"]).tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.numberOfRows(inSection: 0), 2)
    }
    func test_viewDidLoad_rendersOptionsText() {
        
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.title(at: 0), "A1")
        XCTAssertEqual(makeSUT(options: ["A1", "A2"]).tableView.title(at: 1), "A2")
    }
    
    // MARK: - Helpers
    
    func makeSUT(question: String = "", options: [String] = []) -> QuestionViewControler {
        let sut = QuestionViewControler(question: question, options: options)
        _ = sut.view
        return sut
    }
}

private extension UITableView {
    func cell(at row: Int) -> UITableViewCell? {
        
        return dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
    }
    
    func title(at row: Int) -> String? {
        return cell(at: row)?.textLabel?.text
    }
}
