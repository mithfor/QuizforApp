//
//  ResultsPresenter.swift
//  QuizforApp
//
//  Created by Dmitriy Voronin on 03.07.2023.
//

import Foundation
import QuizforEngine

final class ResultsPresenter {

    typealias Answers = [(question: Question<String>, answer: [String])]
    typealias Scorer = ([[String]], [[String]]) -> Int

    private let userAnswers: Answers
    private let correctAnswers: Answers
    private let scorer: Scorer

    init(userAnswers: Answers, correctAnswers: Answers, scorer: @escaping Scorer) {
        self.userAnswers = userAnswers
        self.correctAnswers = correctAnswers
        self.scorer = scorer
    }

    var title: String {
        return "Result"
    }

    var summary: String {
        return "You got \(score)/\(userAnswers.count) correct"
    }

    private var score: Int {
        return scorer(userAnswers.map { $0.answer }, correctAnswers.map { $0.answer })
    }

    var presentableAnswers: [PresentableAnswer] {
        return zip(userAnswers, correctAnswers).map { userAnswer, correctAnswer in
            return presentableAnswer(userAnswer.question, userAnswer.answer, correctAnswer.answer)

        }
    }

    private func presentableAnswer(_ question: Question<String>,
                                   _ userAnswer: [String],
                                   _ correctAnswer: [String]) -> PresentableAnswer {

        switch question {
        case .singleAnswer(let value), .multipleAnswer(let value):
            return PresentableAnswer(question: value,
                                     answer: formattedAnswer(correctAnswer),
                                     wrongAnswer: formattedWrongAnswer(question,
                                                              userAnswer,
                                                              correctAnswer))

        }

    }

    private func formattedAnswer(_ answer: [String]) -> String {
        return answer.joined(separator: ", ")
    }

    private func formattedWrongAnswer(_ question: Question<String>,
                                      _ userAnswer: [String],
                                      _ correctAnswer: [String]) -> String? {
        return correctAnswer == userAnswer ? nil : formattedAnswer(userAnswer)
    }

}
