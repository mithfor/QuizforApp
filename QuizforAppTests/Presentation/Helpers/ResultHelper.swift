//
//  ResultHelper.swift
//  QuizforAppTests
//
//  Created by Dmitriy Voronin on 03.07.2023.
//

@testable import QuizforEngine

extension QuizResult {
    static func make(answers: [Question: Answer] = [:], score: Int = 0) -> QuizResult<Question, Answer> {
        return QuizResult(answers: answers, score: score)
    }
}

extension QuizResult: Equatable where Answer: Equatable {
    public static func == (lhs: QuizforEngine.QuizResult<Question, Answer>,
                           rhs: QuizforEngine.QuizResult<Question, Answer>) -> Bool {
        return lhs.score == rhs.score && lhs.answers == rhs.answers
    }
}

extension QuizResult: Hashable where Answer: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(answers)
        hasher.combine(score)
    }
}
