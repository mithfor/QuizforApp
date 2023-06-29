//
//  SceneDelegate.swift
//  QuizforApp
//
//  Created by Dmitrii Voronin on 18.05.2023.
//

import UIKit
import QuizforEngine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)

        //        let questionViewController = QuestionViewControler(question: "A question?", options: ["Option 1", "Option 2"]) {
        //            print( $0)
        //        }
        let viewController = ResultsViewController(summary: "You got 1/2 correct", answers: [
            PresentableAnswer(question: "1-st Question", answer: "Yes", wrongAnswer: nil),
            PresentableAnswer(question: "2-nd Question", answer: "Yeap!", wrongAnswer: "NOT!")
        ])

        _ = viewController.view
        viewController.tableView.allowsMultipleSelection = true

        let navigation = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }

}
