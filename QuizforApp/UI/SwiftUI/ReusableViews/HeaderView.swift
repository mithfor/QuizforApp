//
//  HeaderView.swift
//  QuizforApp
//
//  Created by Dmitriy Voronin on 01.08.2023.
//

import SwiftUI

struct HeaderView: View {

    let title: String
    let question: String

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.headline)
                .fontWeight(.medium)
                .foregroundColor(Color.blue)
                .padding(.top)

            Text(question)
                .font(.largeTitle)
                .fontWeight(.medium)
        }.padding()
    }
}

struct QuestionHeader_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "A title", question: "A question")
            .previewLayout(.sizeThatFits)
    }
}
