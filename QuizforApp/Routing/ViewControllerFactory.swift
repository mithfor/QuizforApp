//
//  ViewControllerFactory.swift
//  QuizforApp
//
//  Created by Dmitriy Voronin on 30.06.2023.
//

import UIKit
import QuizforEngine

protocol ViewControllerFactory {

    typealias Answers = [(question: Question<String>, answers: [String])]
    
    func questionViewController(for question: Question<String>,
                                answerCallback: @escaping ([String]) -> Void) -> UIViewController

    func resultsViewController(for userAnswers: Answers) -> UIViewController

    func resultsViewController(for result: Result<Question<String>, [String]>) -> UIViewController
}
