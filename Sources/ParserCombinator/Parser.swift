//
//  Parser.swift
//
//
//  Created by Griff on 12/14/20.
//

import Foundation

// calling suggestion: alias namespace in your code for convenience
// typealias P = Parser in callers

// Parser<OUTPUT>
// The (generic) definition of our parser
public struct Parser<OUTPUT> {
    // Takes a substring input and returns an OUTPUT if successful
    // removes parsed chararacters from input on success
    // thereby leaving remaining input
    public let parse: (_ input: inout Substring) -> OUTPUT?
}

public extension Parser {
    // convenience method to run the parser on a string input (without modifiying it)
    func run(_ string: String) -> (match: OUTPUT?, rest: Substring) {
        var s = string[...]
        let result = parse(&s)
        return (result, s)
    }

    // convenience method to run the parser on a string input (without modifiying it)
    // returning just the result
    func match(_ string: String) -> OUTPUT? {
        run(string).match
    }
}
