//
//  iOSSwiftUINavigationAdapter.swift
//  QuizforApp
//
//  Created by Dmitriy Voronin on 01.08.2023.
//

import SwiftUI
import UIKit
import QuizforEngine


// MARK: iOSSwiftUINavigationAdapter
final class iOSSwiftUINavigationAdapter: QuizDelegate, QuizDataSource {

    typealias Question = QuizforEngine.Question<String>
    typealias Answer = [String]
    typealias Answers = [(question: Question, answer: Answer)]

    private let show: (UIViewController) -> Void
    private let options: [Question: Answer]
    private let correctAnswers: Answers

    private var questions: [Question] {
        return correctAnswers.map { $0.question }
    }

    private var playAgainAction: () -> Void

    init(show: @escaping (UIViewController) -> Void, options: [Question : Answer], correctAnswers: Answers, playAgainAction: @escaping () -> Void) {
        self.show = show
        self.options = options
        self.correctAnswers = correctAnswers
        self.playAgainAction = playAgainAction
    }

    // MARK: QuizDelegate

    func didCompleteQuiz(withAnswers answers: Answers) {
        show(resultsViewController(for: answers))
    }

    // MARK: QuizDataSource

    func answer(for question: Question, completion: @escaping (Answer) -> Void) {
        show(questionViewController(for: question, answerCallback: completion))
    }

    // MARK: Private func

    private func questionViewController(for question: Question, answerCallback: @escaping (Answer) -> Void) -> UIViewController {
        guard let options = self.options[question] else {
            fatalError("Couldn't find options for question: \(question)")
        }

        return questionViewController(for: question, options: options, answerCallback: answerCallback)
    }

    private func resultsViewController(for userAnswers: Answers) -> UIViewController {
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

    private func questionViewController(for question: Question,
                                        options: Answer,
                                        answerCallback: @escaping (Answer) -> Void) -> UIViewController {
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

    private func questionViewController(for question: Question,
                                        value: String,
                                        options: Answer,
                                        allowsMultipleSelection: Bool,
                                        answerCallback: @escaping (Answer) -> Void) -> QuestionViewControler {

        let presenter = QuestionPresenter(questions: questions, question: question)
        let controller = QuestionViewControler(question: value,
                                               options: options,
                                               allowsMultipleSelection: allowsMultipleSelection,
                                               selection: answerCallback)
        controller.title = presenter.title

        return controller
    }
}
