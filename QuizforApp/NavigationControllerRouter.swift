//
//  NavigationControllerRouter.swift
//  QuizforApp
//
//  Created by Dmitriy Voronin on 29.06.2023.
//

import UIKit
import QuizforEngine

enum Question<T: Hashable>: Hashable {
    case singleAnswer(T)
    case multipleAnswer(T)

    func hash(into hasher: inout Hasher) {

        switch self {
        case .singleAnswer(let value):
            hasher.combine(value)

        case .multipleAnswer(let value):
            hasher.combine(value)
        }
    }

    static func == (lhs: Question<T>, rhs: Question<T>) -> Bool {
        switch (lhs, rhs) {
        case ( .singleAnswer(let aValue), .singleAnswer(let bValue) ):
            return aValue == bValue
        case ( .multipleAnswer(let aValue), .multipleAnswer(let bValue) ):
            return aValue == bValue
        default:
            return false
        }
    }
}

protocol ViewControllerFactory {
    func questionViewController(for question: String, answerCallback: @escaping (String) -> Void) -> UIViewController
}

class NavigationControllerRouter: Router {

    private var navigationController: UINavigationController
    private var factory: ViewControllerFactory

    init(_ navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }

    func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
        let viewController = factory.questionViewController(for: question, answerCallback: answerCallback)
        navigationController.pushViewController(viewController, animated: true)
    }

    func routeTo(result: Result<String, String>) {

    }
}
