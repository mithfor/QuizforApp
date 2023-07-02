//
//  IOSViewControllerFactory.swift
//  QuizforApp
//
//  Created by Dmitriy Voronin on 30.06.2023.
//

import UIKit
import QuizforEngine

class IOSViewControllerFactory: ViewControllerFactory {
    func questionViewController(for question: Question<String>, answerCallback: @escaping (String) -> Void) -> UIViewController {
        return QuestionViewControler()
    }

    func resultViewController(for result: QuizforEngine.QuizResult<Question<String>, String>) -> UIViewController {
        return UIViewController()
    }
}
