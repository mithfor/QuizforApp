//
//  NavigationControlerRouterTest.swift
//  QuizforAppTests
//
//  Created by Dmitriy Voronin on 29.06.2023.
//

import UIKit
import XCTest
@testable import QuizforApp
@testable import QuizforEngine

class NavigationControlerRouterTest: XCTestCase {

    let navigationController = NoneAnimatedNavigationController()
    let factory = ViewControllerFactoryStub()

    lazy var sut: NavigationControllerRouter = {
        return NavigationControllerRouter(self.navigationController, factory: self.factory)
    }()

    func test_routeToQuestion_showsQuestionController() {

        let viewController = UIViewController()
        let secondViewController = UIViewController()
        factory.stub(question: Question.singleAnswer("Q1"), with: viewController)
        factory.stub(question: Question.singleAnswer("Q2"), with: secondViewController)

        sut.routeTo(question: Question.singleAnswer("Q1"), answerCallback: { _ in })
        sut.routeTo(question: Question.singleAnswer("Q2"), answerCallback: { _ in })

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }

    func test_routeToResult_showsResutController() {

        let viewController = UIViewController()
        let result = QuizResult.make(answers: [Question.singleAnswer("Q1"): ["A1"]], score: 10)

        let secondViewController = UIViewController()
        let secondResult = QuizResult.make(answers: [Question.singleAnswer("Q2"): ["A2"]], score: 20)

        factory.stub(result: result, with: viewController)
        factory.stub(result: secondResult, with: secondViewController)

        sut.routeTo(result: result)
        sut.routeTo(result: secondResult)

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }

    func test_routeToQuestion_singleAnswer_answerCallback_progressesToNextQuestion() {

        var callbackWasFired = false
        sut.routeTo(question: Question.singleAnswer("Q1"), answerCallback: { _ in callbackWasFired = true})
        factory.answerCallback[Question.singleAnswer("Q1")]!(["anything"])

        XCTAssertTrue(callbackWasFired)
    }

    func test_routeToQuestion_multipleAnswer_answerCallback_doesNotConfigureViewControllerWithSubmitButton() {

        let viewController = UIViewController()

        factory.stub(question: Question.singleAnswer("Q1"), with: viewController)

        sut.routeTo(question: Question.singleAnswer("Q1"), answerCallback: { _ in })

        XCTAssertNil(viewController.navigationItem.rightBarButtonItem)
    }

    func test_routeToQuestion_multipleAnswer_answerCallback_doesNotProgresstoNextQuestion() {

        var callbackWasFired = false
        sut.routeTo(question: Question.multipleAnswer("Q1"), answerCallback: { _ in callbackWasFired = true})
        factory.answerCallback[Question.multipleAnswer("Q1")]!(["anything"])

        XCTAssertFalse(callbackWasFired)
    }

    func test_routeToQuestion_multipleAnswer_configuresViewControllerWithSubmitButton() {

        let viewController = UIViewController()

        factory.stub(question: Question.multipleAnswer("Q1"), with: viewController)

        sut.routeTo(question: Question.multipleAnswer("Q1"), answerCallback: { _ in })

        XCTAssertNotNil(viewController.navigationItem.rightBarButtonItem)
    }

    func test_routeToQuestion_multipleAnswerSubmitButton_isDisabledWhenZeroAnswersSelected() {

        let viewController = UIViewController()

        factory.stub(question: Question.multipleAnswer("Q1"), with: viewController)

        sut.routeTo(question: Question.multipleAnswer("Q1"), answerCallback: { _ in })
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)

        factory.answerCallback[Question.multipleAnswer("Q1")]!(["A1"])
        XCTAssertTrue(viewController.navigationItem.rightBarButtonItem!.isEnabled)

        factory.answerCallback[Question.multipleAnswer("Q1")]!([])
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)

    }

    func test_routeToQuestion_multipleAnswerSubmitButton_progressesToNextQuestion() {

        let viewController = UIViewController()
        factory.stub(question: Question.multipleAnswer("Q1"), with: viewController)

        var callbackWasFired = false
        sut.routeTo(question: Question.multipleAnswer("Q1"), answerCallback: { _ in callbackWasFired = true})
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)

        factory.answerCallback[Question.multipleAnswer("Q1")]!(["A1"])

        let button = viewController.navigationItem.rightBarButtonItem!

        button.simulateTap()

        XCTAssertTrue(callbackWasFired)
    }

    class NoneAnimatedNavigationController: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }

    class ViewControllerFactoryStub: ViewControllerFactory {

        private var stubbedQuestions = [Question<String>: UIViewController]()
        private var stubbedResult = [QuizResult<Question<String>, [String]>: UIViewController]()

        var answerCallback = [Question<String>: ([String]) -> Void]()

        func stub(question: Question<String>, with viewController: UIViewController) {
            stubbedQuestions[question] = viewController
        }

        func stub(result: QuizResult<Question<String>, [String]>, with viewController: UIViewController) {
            stubbedResult[result] = viewController
        }

        func questionViewController(for question: Question<String>,
                                    answerCallback: @escaping ([String]) -> Void) -> UIViewController {
            self.answerCallback[question] = answerCallback
            return stubbedQuestions[question] ?? UIViewController()
        }

        func resultViewController(for result: QuizResult<Question<String>, [String]>) -> UIViewController {
            return stubbedResult[result] ?? UIViewController()
        }

    }
}

private extension UIBarButtonItem {
    func simulateTap() {
        target?.performSelector(onMainThread: action!, with: nil, waitUntilDone: true)
    }
}
