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
    private var question = ""
    private var options = [String]()
    private let reuseIdentifier = "Cell"
    
    convenience init(question: String, options: [String]) {
        self.init()
        self.question = question
        self.options = options
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

