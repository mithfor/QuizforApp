//
//  ResultsViewController.swift
//  QuizforApp
//
//  Created by Dmitriy Voronin on 09.06.2023.
//

import UIKit

struct PresentableAnswer {
    let question: String
    let answer: String
    let isCorrect: Bool
}



class ResultsViewController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    private var summary = ""
    private var answers = [PresentableAnswer]()
    
    convenience init(summary: String, answers: [PresentableAnswer]) {
        self.init()
        self.summary = summary
        self.answers = answers
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        headerLabel.text = summary

        tableView.register(UINib(nibName: "CorrectAnswerCell", bundle: nil), forCellReuseIdentifier: "CorrectAnswerCell")
        tableView.register(UINib(nibName: "WrongAnswerCell", bundle: nil), forCellReuseIdentifier: "WrongAnswerCell")
    }
}

extension ResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answer = answers[indexPath.row]

        if answer.isCorrect {
            return createCorrectAnswerCell(for: answer)
        }
        return createWrongAnswerCell(for: answer)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }

    private func createCorrectAnswerCell(for answer: PresentableAnswer) -> CorrectAnswerCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CorrectAnswerCell") as! CorrectAnswerCell
        cell.questionLabel.text = answer.question
        cell.answerLabel.text = answer.answer
        return cell
    }

    private func createWrongAnswerCell(for answer: PresentableAnswer) -> WrongAnswerCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WrongAnswerCell") as! WrongAnswerCell
        cell.questionLabel.text = answer.question
        cell.correctAnswerLabel.text = answer.answer
        return cell
    }
}
