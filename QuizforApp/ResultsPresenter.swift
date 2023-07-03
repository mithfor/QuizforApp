//
//  ResultsPresenter.swift
//  QuizforApp
//
//  Created by Dmitriy Voronin on 03.07.2023.
//

import Foundation
import QuizforEngine

struct ResultsPresenter {

    let result: QuizResult<Question<String>, [String]>

    var summary: String {
        return "You got \(result.score)/\(result.answers.count) correct"
    }
}
