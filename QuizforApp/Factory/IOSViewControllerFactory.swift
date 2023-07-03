//
//  IOSViewControllerFactory.swift
//  QuizforApp
//
//  Created by Dmitriy Voronin on 30.06.2023.
//

import UIKit
import QuizforEngine

class IOSViewControllerFactory: ViewControllerFactory {

    private let questions: [Question<String>]
    private let options: [Question<String>: [String]]

    init(questions: [Question<String>], options: [Question<String>: [String]]) {
        self.questions = questions
        self.options = options

    }

    func questionViewController(for question: Question<String>,
                                answerCallback: @escaping ([String]) -> Void) -> UIViewController {
        guard let options = self.options[question] else {
            fatalError("Couldn't find options for question: \(question)")
        }

        return questionViewController(for: question, options: options, answerCallback: answerCallback)

    }

    private func questionViewController(for question: Question<String>, options: [String], answerCallback: @escaping ([String]) -> Void) -> UIViewController {

        switch question {
        case .singleAnswer(let value):

            return questionViewController(for: question, value: value, options: options, answerCallback: answerCallback)
            
        case .multipleAnswer(let value):
            let controller = questionViewController(for: question, value: value, options: options, answerCallback: answerCallback)

            _ = controller.view
            controller.tableView.allowsMultipleSelection = true
            return controller
        }
    }

    private func questionViewController(for question: Question<String>,
                                        value: String,
                                        options: [String],
                                        answerCallback: @escaping ([String]) -> Void) -> QuestionViewControler {

        let presenter = QuestionPresenter(questions: questions, question: question)
        let controller =  QuestionViewControler(question: value,
                                     options: options,
                                     selection: answerCallback)
        controller.title = presenter.title

        return controller
    }

    func resultViewController(for result: QuizforEngine.QuizResult<Question<String>, [String]>) -> UIViewController {
        return UIViewController()
    }
}
