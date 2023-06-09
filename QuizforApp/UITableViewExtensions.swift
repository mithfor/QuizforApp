//
//  UITableViewExtensions.swift
//  QuizforApp
//
//  Created by Dmitriy Voronin on 09.06.2023.
//

import UIKit

extension UITableView {
    func register(_ type: UITableViewCell.Type) {
        let className = String(describing: type)
        register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
    }
    func dequeueReusableCell<T>(_ type: T.Type) -> T? {
        let classname = String(describing: type)
        return dequeueReusableCell(withIdentifier: classname) as? T
    }
}
