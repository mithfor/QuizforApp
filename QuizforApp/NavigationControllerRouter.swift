//
//  NavigationControllerRouter.swift
//  QuizforApp
//
//  Created by Dmitriy Voronin on 29.06.2023.
//

import UIKit
import QuizforEngine

class NavigationControllerRouter: Router {

    private var navigationController = UINavigationController()

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func routeTo(question: Question, answerCallback: @escaping (String) -> Void) {
        navigationController.pushViewController(UIViewController(), animated: false)
    }

    func routeTo(result: Result<String, String>) {

    }
}
