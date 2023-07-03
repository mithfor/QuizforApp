//
//  QuestionPresenter.swift
//  QuizforApp
//
//  Created by Dmitriy Voronin on 04.07.2023.
//

import Foundation

// swiftlint:disable force_cast

struct QuestionPresenter {
    let questions: [Question<String>]
    let question: Question<String>

    var title: String {

        guard let index = questions.firstIndex(of: question) else { return "" }

        return "Question #\(index + 1)"
    }
}

// swiftlint:enable force_cast
