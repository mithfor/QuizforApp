//
//  IOSViewControllerFactory.swift
//  QuizforApp
//
//  Created by Dmitriy Voronin on 30.06.2023.
//

import UIKit
import QuizforEngine

class IOSViewControllerFactory: ViewControllerFactory {

    let options: [Question<String>: [String]]

    init(options: [Question<String>: [String]]) {
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
            let controller =  QuestionViewControler(question: value,
                                         options: options,
                                         selection: answerCallback)
            controller.title = "Question #1"
            return controller
            
        case .multipleAnswer(let value):
            let controller = QuestionViewControler(question: value,
                                                   options: options,
                                                   selection: answerCallback)
            _ = controller.view
            controller.tableView.allowsMultipleSelection = true
            return controller
        }
    }

    func resultViewController(for result: QuizforEngine.QuizResult<Question<String>, [String]>) -> UIViewController {
        return UIViewController()
    }
}
