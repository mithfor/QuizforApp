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

    func test_answerForQuestion_showsQuestionController() {

        let viewController = UIViewController()
        let secondViewController = UIViewController()
        factory.stub(question: singleAnswerQuestion, with: viewController)
        factory.stub(question: multipleAnswerQuestion, with: secondViewController)

        sut.answer(for: singleAnswerQuestion, completion: { _ in })
        sut.answer(for: multipleAnswerQuestion, completion: { _ in })

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }

    func test_didCompleteQuiz_showsResutController() {

        let viewController = UIViewController()
        let userAnswers = [(singleAnswerQuestion, ["A1"])]

        let secondViewController = UIViewController()
        let secondUserAnswers = [(multipleAnswerQuestion, ["A2"])]

        factory.stub(resultForQuestions: [singleAnswerQuestion], with: viewController)
        factory.stub(resultForQuestions: [multipleAnswerQuestion], with: secondViewController)

        sut.didCompleteQuiz(withAnswers: userAnswers)
        sut.didCompleteQuiz(withAnswers: secondUserAnswers)

        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }

    func test_answerForQuestion_singleAnswer_answerCallback_progressesToNextQuestion() {

        var callbackWasFired = false
        sut.answer(for: singleAnswerQuestion, completion: { _ in callbackWasFired = true})
        factory.answerCallback[singleAnswerQuestion]!(["anything"])

        XCTAssertTrue(callbackWasFired)
    }

    func test_answerForQuestion_multipleAnswer_answerCallback_doesNotConfigureViewControllerWithSubmitButton() {
        let question = singleAnswerQuestion

        let viewController = UIViewController()

        factory.stub(question: question, with: viewController)

        sut.answer(for: question, completion: { _ in })

        XCTAssertNil(viewController.navigationItem.rightBarButtonItem)
    }

    func test_answerForQuestion_multipleAnswer_answerCallback_doesNotProgresstoNextQuestion() {
        let multipleQuestion = multipleAnswerQuestion
        var callbackWasFired = false
        sut.answer(for: multipleQuestion, completion: { _ in callbackWasFired = true})
        factory.answerCallback[multipleQuestion]!(["anything"])

        XCTAssertFalse(callbackWasFired)
    }

    func test_answerForQuestion_multipleAnswer_configuresViewControllerWithSubmitButton() {

        let viewController = UIViewController()

        factory.stub(question: multipleAnswerQuestion, with: viewController)

        sut.answer(for: multipleAnswerQuestion, completion: { _ in })

        XCTAssertNotNil(viewController.navigationItem.rightBarButtonItem)
    }

    func test_answerForQuestion_multipleAnswerSubmitButton_isDisabledWhenZeroAnswersSelected() {

        let viewController = UIViewController()

        factory.stub(question: multipleAnswerQuestion, with: viewController)

        sut.answer(for: multipleAnswerQuestion, completion: { _ in })
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)

        factory.answerCallback[multipleAnswerQuestion]!(["A1"])
        XCTAssertTrue(viewController.navigationItem.rightBarButtonItem!.isEnabled)

        factory.answerCallback[multipleAnswerQuestion]!([])
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)

    }

    func test_answerForQuestion_multipleAnswerSubmitButton_progressesToNextQuestion() {

        let viewController = UIViewController()
        factory.stub(question: multipleAnswerQuestion, with: viewController)

        var callbackWasFired = false
        sut.answer(for: multipleAnswerQuestion, completion: { _ in callbackWasFired = true})
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)

        factory.answerCallback[multipleAnswerQuestion]!(["A1"])

        viewController.navigationItem.rightBarButtonItem?.simulateTap()

        XCTAssertTrue(callbackWasFired)
    }

    // MARK: - Helpers

    private let navigationController = NoneAnimatedNavigationController()
    private let factory = ViewControllerFactoryStub()

    private let singleAnswerQuestion = Question.singleAnswer("Q1")
    private let singleAnswerQuestion2 = Question.singleAnswer("Q2")

    private let multipleAnswerQuestion = Question.multipleAnswer("Q2")

    private lazy var sut: NavigationControllerRouter = {
        return NavigationControllerRouter(self.navigationController, factory: self.factory)
    }()

    private class NoneAnimatedNavigationController: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }

    private class ViewControllerFactoryStub: ViewControllerFactory {

        private var stubbedQuestions = [Question<String>: UIViewController]()
        private var stubbedResults = [[Question<String>]: UIViewController]()

        var answerCallback = [Question<String>: ([String]) -> Void]()

        func stub(question: Question<String>, with viewController: UIViewController) {
            stubbedQuestions[question] = viewController
        }

        func stub(resultForQuestions questions: [Question<String>], with viewController: UIViewController) {
            stubbedResults[questions] = viewController
        }

        func questionViewController(for question: Question<String>,
                                    answerCallback: @escaping ([String]) -> Void) -> UIViewController {
            self.answerCallback[question] = answerCallback
            return stubbedQuestions[question] ?? UIViewController()
        }

        func resultsViewController(for userAnswers: Answers) -> UIViewController {
            return stubbedResults[userAnswers.map { $0.question }] ?? UIViewController()
        }

        func resultsViewController(for result: Result<Question<String>, [String]>) -> UIViewController {
            return UIViewController()
        }

    }
}

private extension UIBarButtonItem {
    func simulateTap() {
        target?.performSelector(onMainThread: action!, with: nil, waitUntilDone: true)
    }
}
