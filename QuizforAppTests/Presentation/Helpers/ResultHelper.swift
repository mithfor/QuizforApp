//
//  ResultHelper.swift
//  QuizforAppTests
//
//  Created by Dmitriy Voronin on 03.07.2023.
//

@testable import QuizforEngine

extension QuizResult: Hashable {

    static func make(answers: [Question: Answer] = [:], score: Int = 0) -> QuizResult<Question, Answer> {
        return QuizResult(answers: answers, score: score)
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(1)
    }

    public static func == (lhs: QuizforEngine.QuizResult<Question, Answer>,
                           rhs: QuizforEngine.QuizResult<Question, Answer>) -> Bool {
        return lhs.score == rhs.score
    }
}
