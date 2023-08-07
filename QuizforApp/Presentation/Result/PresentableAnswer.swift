//
//  PresentableAnswer.swift
//  QuizforApp
//
//  Created by Dmitriy Voronin on 09.06.2023.
//

import Foundation

struct PresentableAnswer: Equatable {
    let question: String
    let answer: String
    let wrongAnswer: String?
}
