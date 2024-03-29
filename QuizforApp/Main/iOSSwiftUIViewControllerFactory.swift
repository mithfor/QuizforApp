//
//  iOSSwiftUIViewControllerFactory.swift
//  QuizforApp
//
//  Created by Dmitriy Voronin on 01.08.2023.
//

import SwiftUI
import UIKit
import QuizforEngine

final class iOSSwiftUIViewControllerFactory: ViewControllerFactory {

    typealias Answers = [(question: Question<String>, answer: [String])]

    private let options: [Question<String>: [String]]
    private let correctAnswers: Answers

    private var questions: [Question<String>] {
        return correctAnswers.map { $0.question }
    }

    private var playAgainAction: () -> Void

    init(options: [Question<String> : [String]], correctAnswers: Answers, playAgainAction: @escaping () -> Void) {
        self.options = options
        self.correctAnswers = correctAnswers
        self.playAgainAction = playAgainAction
    }

    func questionViewController(for question: QuizforEngine.Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
        guard let options = self.options[question] else {
            fatalError("Couldn't find options for question: \(question)")
        }

        return questionViewController(for: question, options: options, answerCallback: answerCallback)
    }

    private func questionViewController(for question: Question<String>,
                                        options: [String],
                                        answerCallback: @escaping ([String]) -> Void) -> UIViewController {
        let presenter = QuestionPresenter(questions: questions, question: question)


        switch question {
        case .singleAnswer(let value):

            return UIHostingController(rootView: SingleAnswerQuestion(title: presenter.title,
                                                                      question: value,
                                                                      options: options,
                                                                      selection: { answerCallback([$0]) }))

        case .multipleAnswer(let value):

            let store = MultipleSelectionStore(options: options, handler: answerCallback)

            return UIHostingController(
                rootView: MultipleAnswerQuestion(
                    title: presenter.title,
                    question: value,
                    store: store
                ))
        }
    }

    private func questionViewController(for question: Question<String>,
                                        value: String,
                                        options: [String],
                                        allowsMultipleSelection: Bool,
                                        answerCallback: @escaping ([String]) -> Void) -> QuestionViewControler {

        let presenter = QuestionPresenter(questions: questions, question: question)
        let controller = QuestionViewControler(question: value,
                                               options: options,
                                               allowsMultipleSelection: allowsMultipleSelection,
                                               selection: answerCallback)
        controller.title = presenter.title

        return controller
    }

    func resultsViewController(for userAnswers: Answers) -> UIViewController {
        let presenter = ResultsPresenter(userAnswers: userAnswers,
                                         correctAnswers: correctAnswers,
                                         scorer: BasicScore.score)

        return UIHostingController(
            rootView: ResultView(
                title: presenter.title,
                summary: presenter.summary,
                answers: presenter.presentableAnswers,
                playAgain: playAgainAction))
    }
}
