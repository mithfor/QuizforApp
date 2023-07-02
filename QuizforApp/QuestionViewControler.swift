//
//  QuestionViewControler.swift
//  QuizforApp
//
//  Created by Dmitrii Voronin on 18.05.2023.
//

import Foundation
import UIKit

class QuestionViewControler: UIViewController {
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    private(set) var question = ""
    private(set) var options = [String]()
    private let reuseIdentifier = "Cell"
    private var selection: (([String]) -> Void)?

    convenience init(question: String, options: [String], selection: @escaping ([String]) -> Void) {
        self.init()
        self.question = question
        self.options = options
        self.selection = selection
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        headerLabel.text = question
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    private func dequeueCell(in tableVew: UITableView) -> UITableViewCell {
        if let cell = tableVew.dequeueReusableCell(withIdentifier: reuseIdentifier) {
            return cell
        }

        return UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
    }

   private func selectedOptions(in tableView: UITableView) -> [String] {
        guard let indexPaths = tableView.indexPathsForSelectedRows else { return [] }
        return indexPaths.map { options[$0.row] }
    }
}

extension QuestionViewControler: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = dequeueCell(in: tableView)

        cell.textLabel?.text = options[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
}

extension QuestionViewControler: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection?(selectedOptions(in: tableView))
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.allowsMultipleSelection {
            selection?(selectedOptions(in: tableView))
        }
    }
}
