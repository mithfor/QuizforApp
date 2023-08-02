//
//  MultipleSelectionStoreTest.swift
//  QuizforAppTests
//
//  Created by Dmitriy Voronin on 02.08.2023.
//

import XCTest

struct MultipleSelectionStore {

    var options: [MultipleSelectionOption]

    internal init(options: [String]) {
        self.options = options.map { MultipleSelectionOption(text: $0) }
    }
}

struct MultipleSelectionOption {
    let text: String
    var isSelected = false

    mutating func select() {
        isSelected.toggle()
    }
}

final class MultipleSelectionStoreTest: XCTestCase {

    func test_selectOption_togglesState() {
        var sut = MultipleSelectionStore(options: ["o0", "o1"])
        XCTAssertFalse(sut.options[0].isSelected)

        sut.options[0].select()
        XCTAssertTrue(sut.options[0].isSelected)

        sut.options[0].select()
        XCTAssertFalse(sut.options[0].isSelected)
    }


}
