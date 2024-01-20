//
//  File.swift
//  FinalProject
//
//  Created by Ерасыл Еркин on 19.12.2023.
//

import Foundation

struct TextSizeModel {
    let big: BigSize
    let small: SmallSize
    let medium: MediumSize
    
}

struct BigSize {
    let titleLabel = 25
    let content = 20
}

struct MediumSize {
    let titleLabel = 20
    let content = 15
}

struct SmallSize {
    let titleLabel = 16
    let content = 12
}


