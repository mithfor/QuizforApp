//
//  MultipleSelectionStore.swift
//  QuizforApp
//
//  Created by Dmitriy Voronin on 02.08.2023.
//

import Foundation

struct MultipleSelectionStore {

    var options: [MultipleSelectionOption]
    var canSubmit: Bool {

        !options.filter(\.isSelected).isEmpty
    }

    private let handler: ([String]) -> Void

    internal init(options: [String], handler: @escaping ([String]) -> Void = { _ in }) {
        self.options = options.map { MultipleSelectionOption(text: $0) }
        self.handler = handler
    }

    func submit() {
        guard canSubmit else { return }
        handler(options.filter(\.isSelected).map(\.text))
    }
}

struct MultipleSelectionOption {
    let text: String
    var isSelected = false


    mutating func select() {
        isSelected.toggle()
    }
}
