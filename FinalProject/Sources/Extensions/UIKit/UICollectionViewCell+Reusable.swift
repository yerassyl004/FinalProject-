//
//  UICollectionViewCell+Reusable.swift
//  FinalProject
//
//  Created by Ерасыл Еркин on 16.05.2024.
//

import Foundation
import UIKit

extension UICollectionViewCell: Reusable {}

extension Reusable where Self: UICollectionViewCell {
    
    static var reuseID: String {
        return String(describing: self)
    }
}
