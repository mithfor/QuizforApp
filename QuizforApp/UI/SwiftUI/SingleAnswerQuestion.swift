//
//  SingleAnswerQuestion.swift
//  QuizforApp
//
//  Created by Dmitriy Voronin on 01.08.2023.
//

import SwiftUI

struct SingleAnswerQuestion: View {
    let title: String
    let question: String
    let options: [String]
    let selection: (String) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            QuestionHeader(title: title, question: question)

            ForEach(options, id: \.self) { option in
                Button(action: {}, label: {
                    HStack {
                        Circle()
                            .stroke(Color.secondary, lineWidth: 2.5)
                            .frame(width: 40.0, height: 40.0)
                        Text(option)
                            .font(.title)
                            .foregroundColor(Color.secondary)
                        Spacer()
                    }.padding()

                })
            }

            Spacer()
        }
    }
}

struct SingleAnswerQuestion_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SingleAnswerQuestion(
                title: "1 of 2",
                question: "What is the fifth planet from the sun?",
                options: [
                    "Venus",
                    "Jupiter",
                    "Earth",
                    "Pluto"
                ],
                selection: { _ in })

            SingleAnswerQuestion(
                title: "1 of 2",
                question: "What is the fifth planet from the sun?",
                options: [
                    "Venus",
                    "Jupiter",
                    "Earth",
                    "Pluto"
                ],
                selection: { _ in }).preferredColorScheme(.dark)
        }
    }
}


