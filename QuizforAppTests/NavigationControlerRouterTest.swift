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

    let navigationController = NoneAnimatedNavigationController()
    let factory = ViewControllerFactoryStub()

    lazy var sut: NavigationControllerRouter = {
        return NavigationControllerRouter(self.navigationController, factory: self.factory)
    }()

    func test_routeToSecondQuestion_presentQuestionController() {

        let viewController = UIViewController()
        let secondViewController = UIViewController()
        factory.stub(question: "Q1", with: viewController)
        factory.stub(question: "Q2", with: secondViewController)

        sut.routeTo(question: "Q1", answerCallback: { _ in })
        sut.routeTo(question: "Q2", answerCallback: { _ in })

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }

    func test_routeToQuestion_presentQuestionControllerWithRightCallback() {

        var callbackWasFired = false
        sut.routeTo(question: "Q1", answerCallback: { _ in callbackWasFired = true})
        factory.answerCallback["Q1"]!("anything")

        XCTAssertTrue(callbackWasFired)
    }

    class NoneAnimatedNavigationController: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }

    class ViewControllerFactoryStub: ViewControllerFactory {

        private var stubbedQuestions = [String: UIViewController]()
        var answerCallback = [String: (String) -> Void]()

        func stub(question: String, with viewController: UIViewController) {
            stubbedQuestions[question] = viewController
        }

        func questionViewController(for question: String, answerCallback: @escaping (String) -> Void) -> UIViewController {
            self.answerCallback[question] = answerCallback
            return stubbedQuestions[question] ?? UIViewController()
        }
    }
}
