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
    var quiz: Quiz?
    private lazy var navigationController = UINavigationController(rootViewController: QuestionViewControler())

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        startNewQuizfor()
    }

    private func startNewQuizfor() {
        let question1 = Question.singleAnswer("What is the fifth planet from the sun?")
        let question2 = Question.multipleAnswer("Tag famous Astronomers.")
        let questions = [question1, question2]

        let option11 = "Venus"
        let option12 = "Jupiter"
        let option13 = "Earth"

        let options1 = [option11, option12, option13]

        let option21 = "Copernicus"
        let option22 = "Rogozin"
        let option23 = "Hubble"

        let options2 = [option21, option22, option23]

        let correctAnswers = [(question1, [option12]),
                              (question2, [option21, option23])]

        let options = [question1: options1, question2: options2]

        let adapter = iOSSwiftUINavigationAdapter(
            navigation: navigationController,
            options: options,
            correctAnswers: correctAnswers,
            playAgainAction: startNewQuizfor
        )

        quiz = Quiz.start(questions: questions, delegate: adapter, dataSource: adapter)
    }
}
