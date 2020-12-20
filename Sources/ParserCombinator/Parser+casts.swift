//
//  File.swift
//
//
//  Created by Griff on 12/19/20.
//

import Foundation

public extension Parser where A == [Character] {
    var string: Parser<String> {
        compactMap { String($0) }
    }

    var int: Parser<Int> {
        string.compactMap { Int($0) }
    }
}

public extension Parser where A == Substring {
    var string: Parser<String> {
        compactMap { String($0) }
    }
}
