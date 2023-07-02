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

    func questionViewController(for question: Question<String>, answerCallback: @escaping (String) -> Void) -> UIViewController {
        return QuestionViewControler(question: "", options: options[question]!) { _ in }
    }

    func resultViewController(for result: QuizforEngine.QuizResult<Question<String>, String>) -> UIViewController {
        return UIViewController()
    }
}
