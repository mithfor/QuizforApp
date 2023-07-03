//
//  ResultsPresenter.swift
//  QuizforApp
//
//  Created by Dmitriy Voronin on 03.07.2023.
//

import Foundation
import QuizforEngine

// swiftlint:disable force_cast

struct ResultsPresenter {

    let result: QuizResult<Question<String>, [String]>
    let questions: [Question<String>]
    let correctAnswers: [Question<String>: [String]]

    var summary: String {
        return "You got \(result.score)/\(result.answers.count) correct"
    }

    var presentableAnswers: [PresentableAnswer] {
        return questions.map { (question) in

            guard let userAnswer = result.answers[question],
                  let correctAnswer = correctAnswers[question] else {
                fatalError("Couldn't find correct answer fo question: \(question)")
            }

            return presentableAnswer(question, userAnswer, correctAnswer)

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

// swiftlint:enable force_cast
