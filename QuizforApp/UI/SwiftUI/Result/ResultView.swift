//
//  ResultView.swift
//  QuizforApp
//
//  Created by Dmitriy Voronin on 05.08.2023.
//

import SwiftUI

struct ResultView: View {

    let title: String
    let summary: String
    let answers: [PresentableAnswer]
    let playAgain: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing:  0.0) {
                HeaderView(title: title,
                           subtitle: summary)

            List(answers, id: \.question) { answer in
                ResultAnswerCell(model: answer)
            }

            Spacer()

            RoundedButton(title: "Play again", action: playAgain)
                .padding()
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ResultTestView()
            ResultTestView()
                .preferredColorScheme(.dark)
                .environment(\.sizeCategory, .extraExtraExtraLarge)
        }
    }

    struct ResultTestView: View {
        @State var playAgainCount = 0
        var body: some View {

            VStack {
                ResultView(title: "Result",
                           summary: "You got 2/5 correct",
                           answers: [
                            .init(question: "What is the answer on question #1?", answer: "A correct answer", wrongAnswer: "A wrong answer"),
                            .init(question: "What is the answer on question #2?", answer: "A correct answer", wrongAnswer: "A wrong answer"),
                            .init(question: "What is the answer on question #3?", answer: "A correct answer", wrongAnswer: nil),
                            .init(question: "What is the answer on question #4?", answer: "A correct answer", wrongAnswer: "A wrong answer"),
                            .init(question: "What is the answer on question #5?", answer: "A correct answer", wrongAnswer: nil)
                           ], playAgain: { playAgainCount += 1 })

                Text("Play again count: \(playAgainCount)")
            }
        }
    }
    
}
