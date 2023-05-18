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
    private var question: String = ""
    private var options: [String] = []
    
    convenience init(question: String, options: [String]) {
        self.init()
        self.question = question
        self.options = options
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerLabel.text = question
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension QuestionViewControler: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
//        var content = cell.defaultContentConfiguration()
//        content.text = options[indexPath.row]
//        cell.contentConfiguration = content
        
        cell.textLabel?.text = options[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
}

