//
//  File.swift
//
//
//  Created by Griff on 12/26/20.
//

import Foundation

extension Parser {
    // recursive
    // parser that takes itself as a parameter
    static func recursive(_ impl: Self, _ recurse: @escaping (Self) -> Self) -> Self {
        recurse(impl)
    }
}
