//
//  ViewControllerFactory.swift
//  QuizforApp
//
//  Created by Dmitriy Voronin on 30.06.2023.
//

import UIKit
import QuizforEngine

protocol ViewControllerFactory {
    func questionViewController(for question: Question<String>,
                                answerCallback: @escaping (String) -> Void) -> UIViewController

    func resultViewController(for result: QuizResult<Question<String>, String>) -> UIViewController
}

