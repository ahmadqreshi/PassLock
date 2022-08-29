//
//  UITableView+Extension.swift
//  PassLock
//
//  Created by Ahmad Qureshi on 04/08/22.
//

import Foundation
import UIKit
extension UITableView {
    func registerCell(cellIdentifier identifier : String) {
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
}
