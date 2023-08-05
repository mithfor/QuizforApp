//
//  MultipleTextSelectionCell.swift
//  QuizforApp
//
//  Created by Dmitriy Voronin on 02.08.2023.
//

import SwiftUI

struct MultipleTextSelectionCell: View {

//    let text: String
//    let isSelected: Bool
//    let selection: () -> Void

    @Binding var option: MultipleSelectionOption

    var body: some View {

        Button(action: { option.toggleSelection() }, label: {
            HStack {
                Rectangle()
                    .strokeBorder(option.isSelected ? Color.blue : Color.secondary, lineWidth: 2.5)
                    .overlay(
                        Rectangle()
                            .fill(option.isSelected ? Color.blue : Color.clear)
                            .frame(width: 26, height: 26)
                    )
                    .frame(width: 40.0, height: 40.0)
                Text(option.text)
                    .font(.title)
                    .foregroundColor(option.isSelected ? Color.blue : .secondary)
                Spacer()
            }.padding()

        })
    }
}

struct MultipleTextSelectionCell_Previews: PreviewProvider {
    static var previews: some View {
        MultipleTextSelectionCell(option: .constant(.init(text: "Earth", isSelected: false)))
            .previewLayout(.sizeThatFits)

        MultipleTextSelectionCell(option: .constant(.init(text: "Earth", isSelected: true)))
            .previewLayout(.sizeThatFits)
    }
}
