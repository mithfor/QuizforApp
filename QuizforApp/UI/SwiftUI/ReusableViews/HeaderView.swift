//
//  HeaderView.swift
//  QuizforApp
//
//  Created by Dmitriy Voronin on 01.08.2023.
//

import SwiftUI

struct HeaderView: View {

    let title: String
    let subtitle: String

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 16) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(Color.blue)
                    .padding(.top)

                Text(subtitle)
                    .font(.largeTitle)
                    .fontWeight(.medium)
            }

            Spacer()
        }.padding()
    }
}

struct QuestionHeader_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "A title", subtitle: "A question")
            .previewLayout(.sizeThatFits)
    }
}
