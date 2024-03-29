//
//  QuestionPresenter.swift
//  QuizforApp
//
//  Created by Dmitriy Voronin on 04.07.2023.
//

import Foundation
import QuizforEngine

struct QuestionPresenter {
    let questions: [Question<String>]
    let question: Question<String>

    var title: String {

        guard let index = questions.firstIndex(of: question) else { return "" }

        return "\(index + 1) of \(questions.count)"
    }
}
