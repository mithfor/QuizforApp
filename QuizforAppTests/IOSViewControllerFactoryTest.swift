//
//  IOSViewControllerFactoryTest.swift
//  QuizforAppTests
//
//  Created by Dmitriy Voronin on 30.06.2023.
//

import Foundation
import XCTest
@testable import QuizforApp

class IOSViewControllerFactoryTest: XCTestCase {

    func test_questionViewController_createsController() {

        let sut = IOSViewControllerFactory()

        let controller = sut.questionViewController(for: Question.singleAnswer("Q1"), answerCallback: { _ in }) as? QuestionViewControler

        XCTAssertNotNil(controller)
    }
}
