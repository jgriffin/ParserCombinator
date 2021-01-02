//
//  Parser+ignoring.swift
//
//
//  Created by Griff on 12/22/20.
//

import Foundation

public extension Parser {
    // ignoring: pi must match, but the result is ignored
    // (OUTPUT) -> Self
    func ignoring<I>(_ pi: Parser<I>) -> Self {
        Self { input in
            let original = input

            guard let output = parse(&input),
                  let _ = pi.parse(&input)
            else {
                input = original
                return nil
            }

            return output
        }
    }
}
