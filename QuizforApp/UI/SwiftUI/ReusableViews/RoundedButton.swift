//
//  RoundedButton.swift
//  QuizforApp
//
//  Created by Dmitriy Voronin on 05.08.2023.
//

import SwiftUI

struct RoundedButton: View {

    let title: String
    let isEnabled: Bool
    let action: () -> Void

    init(title: String, isEnabled: Bool = true, action: @escaping () -> Void) {
        self.title = title
        self.isEnabled = isEnabled
        self.action = action
    }

    var body: some View {
        Button(action: action, label:  {
            HStack {
                Spacer()
                Text(title)
                    .padding()
                    .foregroundColor(.white)
                Spacer()
            }
            .background(Color.blue)
            .cornerRadius(25)

        })
        .buttonStyle(PlainButtonStyle())
        .padding()
        .disabled(!isEnabled)
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButton(title: "Enabled",
                      isEnabled: true,
                      action: {})

        RoundedButton(title: "Disabled",
                      isEnabled: false,
                      action: {})
    }
}
