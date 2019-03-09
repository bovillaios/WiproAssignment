//
//  Fact.swift
//  iOS
//
//  Created by GGKU5MACBOOK003 on 09/03/19.
//  Copyright © 2019 Ramgopal. All rights reserved.
//

import Foundation

struct Fact: Codable {
    let title: String
    var rows: [Row]
}

struct Row: Codable {
    let title: String?
    let description: String?
    let imageHref: String?
}
