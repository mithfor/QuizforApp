//
//  MultipleAnswerQuestionSnapshotTests.swift
//  QuizforAppTests
//
//  Created by Dmitriy Voronin on 02.08.2023.
//

import XCTest
@testable import QuizforApp

final class MultipleAnswerQuestionSnapshotTests: XCTestCase {

    func test_Example() {
        let sut = MultipleAnswerQuestion(
            title: "A title",
            question: "A question",
            store: .init(options: ["Option 1", "Option 2"]))

        assert(snapshot: sut.snapshot(for: SnapshotConfiguration.iPhone13(style: .light)), named: "two_options")
    }
}
