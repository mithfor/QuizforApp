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
        let result = QuizResult.make(answers: [Question.singleAnswer("Q1"): "A1"], score: 10)
        factory.stub(result: result, with: viewController)

        sut.routeTo(result: result)

        XCTAssertEqual(navigationController.viewControllers.count, 1)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
    }

    func test_routeToQuestion_presentQuestionControllerWithRightCallback() {

        var callbackWasFired = false
        sut.routeTo(question: Question.singleAnswer("Q1"), answerCallback: { _ in callbackWasFired = true})
        factory.answerCallback[Question.singleAnswer("Q1")]!("anything")

        XCTAssertTrue(callbackWasFired)
    }

    class NoneAnimatedNavigationController: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }

    class ViewControllerFactoryStub: ViewControllerFactory {

        private var stubbedQuestions = [Question<String>: UIViewController]()
        private var stubbedResult = [QuizResult<Question<String>, String>: UIViewController]()

        var answerCallback = [Question<String>: (String) -> Void]()

        func stub(question: Question<String>, with viewController: UIViewController) {
            stubbedQuestions[question] = viewController
        }

        func stub(result: QuizResult<Question<String>, String>, with viewController: UIViewController) {
            stubbedResult[result] = viewController
        }

        func questionViewController(for question: Question<String>,
                                    answerCallback: @escaping (String) -> Void) -> UIViewController {
            self.answerCallback[question] = answerCallback
            return stubbedQuestions[question] ?? UIViewController()
        }

        func resultViewController(for result: QuizResult<Question<String>, String>) -> UIViewController {
            return stubbedResult[result] ?? UIViewController()
        }

    }
}

extension QuizResult: Hashable {

    static func make(answers: [Question: Answer] = [:], score: Int = 1) -> QuizResult<Question, Answer> {
        return QuizResult(answers: answers, score: score)
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(1)
    }

    public static func == (lhs: QuizforEngine.QuizResult<Question, Answer>,
                           rhs: QuizforEngine.QuizResult<Question, Answer>) -> Bool {
        return lhs.score == rhs.score
    }
}
