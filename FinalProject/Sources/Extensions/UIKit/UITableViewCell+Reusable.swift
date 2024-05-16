//
//  UITableViewCell+Reusable.swift
//  FinalProject
//
//  Created by Ерасыл Еркин on 16.05.2024.
//

import Foundation
import UIKit

protocol Reusable {}

extension UITableViewCell: Reusable {}

extension Reusable where Self: UITableViewCell {
    
    static var reuseID: String {
        return String(describing: self)
    }
}
