//
//  NavigationControllerRouter.swift
//  QuizforApp
//
//  Created by Dmitriy Voronin on 29.06.2023.
//

import UIKit
import QuizforEngine

class NavigationControllerRouter: Router, QuizDelegate {
    func answer(for question: QuizforEngine.Question<String>, completion: @escaping ([String]) -> Void) {

    }

    func didCompleteQuiz(withAnswers: [(question: QuizforEngine.Question<String>, answer: [String])]) {

    }

    private var navigationController: UINavigationController
    private var factory: ViewControllerFactory

    init(_ navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }

    func routeTo(question: Question<String>, answerCallback: @escaping ([String]) -> Void) {

        switch question {
        case .singleAnswer:
            show(factory.questionViewController(for: question, answerCallback: answerCallback))
        case .multipleAnswer:
            let button = UIBarButtonItem(title: "Submit", style: .plain, target: nil, action: nil)
            let buttonController = SubmitButtonController(button, answerCallback)
            let controller  = factory.questionViewController(for: question, answerCallback: { selection in
                buttonController.update(selection)
            })
            controller.navigationItem.rightBarButtonItem = button
            show(controller)
        }

    }

    func routeTo(result: Result<Question<String>, [String]>) {
        show(factory.resultViewController(for: result))
    }

    private func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
}

private class SubmitButtonController: NSObject {
    let button: UIBarButtonItem
    let callback: ([String]) -> Void
    private var model: [String] = []

    init(_ button: UIBarButtonItem, _ callback: @escaping ([String]) -> Void) {
        self.button = button
        self.callback = callback
        super.init()
        self.setup()
    }

    private func setup() {
        button.target = self
        button.action = #selector(fireCallback)
        updateButtonState()
    }

    func update(_ model: [String]) {
        self.model = model
        updateButtonState()
    }

    private func updateButtonState() {
        button.isEnabled = model.count > 0
    }

    @objc
    private func fireCallback() {
        callback(model)
    }
}
