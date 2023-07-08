//
//  ResultHelper.swift
//  QuizforAppTests
//
//  Created by Dmitriy Voronin on 03.07.2023.
//

@testable import QuizforEngine

extension Result {
    static func make(answers: [Question: Answer] = [:], score: Int = 0) -> Result<Question, Answer> {
        return Result(answers: answers, score: score)
    }
}

extension Result: Equatable where Answer: Equatable {
    public static func == (lhs: QuizforEngine.Result<Question, Answer>,
                           rhs: QuizforEngine.Result<Question, Answer>) -> Bool {
        return lhs.score == rhs.score && lhs.answers == rhs.answers
    }
}

extension Result: Hashable where Answer: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(answers)
        hasher.combine(score)
    }
}
