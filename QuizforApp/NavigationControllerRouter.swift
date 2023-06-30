//
//  NavigationControllerRouter.swift
//  QuizforApp
//
//  Created by Dmitriy Voronin on 29.06.2023.
//

import UIKit
import QuizforEngine

protocol ViewControllerFactory {
    func questionViewController(for question: Question<String>,
                                answerCallback: @escaping (String) -> Void) -> UIViewController

    func resultViewController(for result: QuizResult<Question<String>, String>) -> UIViewController
}

class NavigationControllerRouter: Router {

    private var navigationController: UINavigationController
    private var factory: ViewControllerFactory

    init(_ navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }

    func routeTo(question: Question<String>, answerCallback: @escaping (String) -> Void) {
        let viewController = factory.questionViewController(for: question, answerCallback: answerCallback)
        navigationController.pushViewController(viewController, animated: true)
    }

    func routeTo(result: QuizResult<Question<String>, String>) {
        let viewController = factory.resultViewController(for: result)
        navigationController.pushViewController(viewController, animated: true)
    }
}
