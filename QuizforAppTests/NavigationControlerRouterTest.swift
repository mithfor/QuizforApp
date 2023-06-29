//
//  NavigationControlerRouterTest.swift
//  QuizforAppTests
//
//  Created by Dmitriy Voronin on 29.06.2023.
//

import UIKit
import XCTest
@testable import QuizforApp

class NavigationControlerRouterTest: XCTestCase {
    func test_presentQuestionController() {

        let navigationController = UINavigationController()
        let sut = NavigationControllerRouter(navigationController)

        sut.routeTo(question: "Q1", answerCallback: { _ in })

        XCTAssertEqual(navigationController.viewControllers.count, 1)
    }

    func test_presentQuestionControllerTwice() {

        let navigationController = UINavigationController()
        let sut = NavigationControllerRouter(navigationController)

        sut.routeTo(question: "Q1", answerCallback: { _ in })
        sut.routeTo(question: "Q2", answerCallback: { _ in })

        XCTAssertEqual(navigationController.viewControllers.count, 2)
    }
}
