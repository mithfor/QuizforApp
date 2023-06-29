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

    func test_routeToQuestion_presentQuestionController() {

        let navigationController = UINavigationController()
        let factory = ViewControllerFactoryStub()
        let viewController = UIViewController()
        factory.stub(question: "Q1", with: viewController)
        let sut = NavigationControllerRouter(navigationController, factory: factory)

        sut.routeTo(question: "Q1", answerCallback: { _ in })

        XCTAssertEqual(navigationController.viewControllers.count, 1)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
    }

    func test_routeToSecondQuestion_presentQuestionController() {

        let navigationController = UINavigationController()
        let factory = ViewControllerFactoryStub()
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        factory.stub(question: "Q1", with: viewController)
        factory.stub(question: "Q2", with: secondViewController)
        let sut = NavigationControllerRouter(navigationController, factory: factory)

        sut.routeTo(question: "Q1", answerCallback: { _ in })
        sut.routeTo(question: "Q2", answerCallback: { _ in })

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }

    class ViewControllerFactoryStub: ViewControllerFactory {

        private var stubbedQuestions = [String: UIViewController]()

        func stub(question: String, with viewController: UIViewController) {
            stubbedQuestions[question] = viewController
        }

        func questionViewController(for question: String, answerCallback: (String) -> Void) -> UIViewController {
            return stubbedQuestions[question]!
        }
    }
}
