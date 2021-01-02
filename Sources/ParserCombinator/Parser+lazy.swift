//
//  File.swift
//
//
//  Created by Griff on 12/26/20.
//

import Foundation

public extension Parser {
    static func lazy(_ p: @autoclosure @escaping () -> Self) -> Self {
        Self { input in
            p().parse(&input)
        }
    }

    var lazy: Self {
        Self.lazy(self)
    }
}
