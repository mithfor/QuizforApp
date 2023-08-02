//
//  MultipleAnswerQuestion.swift
//  QuizforApp
//
//  Created by Dmitriy Voronin on 02.08.2023.
//

import SwiftUI

struct MultipleAnswerQuestion: View {
    let title: String
    let question: String
    @State var store: MultipleSelectionStore

    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            QuestionHeader(title: title, question: question)

            ForEach(store.options.indices) { i in
                MultipleTextSelectionCell(option: $store.options[i])
            }
        }

        Spacer()

        Button(action: store.submit, label:  {
            HStack {
                Spacer()
                Text("Submit")
                    .padding()
                    .foregroundColor(.white)
                Spacer()
            }
            .background(Color.blue)
            .cornerRadius(25)

        })
        .buttonStyle(PlainButtonStyle())
        .padding()
        .disabled(!store.canSubmit)
    }
}

struct MultipleAnswerQuestion_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MultipleAnswerQuestionTestView()

            MultipleAnswerQuestionTestView().preferredColorScheme(.dark)
        }
    }

    struct MultipleAnswerQuestionTestView: View {
        @State var selection = ["none"]
        var body: some View {
            VStack {
                MultipleAnswerQuestion(
                    title: "2 of 2",
                    question: "Tag famous Astronomers.",
                    store: .init(options: [
                        "Copernicus",
                        "Rogozin",
                        "Hubble"
                    ], handler: { selection = $0 })
                )
                Text("Last submission: " + selection.joined(separator: ", "))
            }
        }
    }
}
