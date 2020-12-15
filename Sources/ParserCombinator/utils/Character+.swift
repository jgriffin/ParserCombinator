//
//  Character+extensions.swift
//
//
//  Created by Griff on 12/14/20.
//

import Foundation

public extension Character {
    var unicodeScalar: UnicodeScalar {
        unicodeScalars.first!
    }
}
