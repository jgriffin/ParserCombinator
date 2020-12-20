//
//  Parser.swift
//
//
//  Created by Griff on 12/14/20.
//

import Foundation

// namespace for common parsers
// suggesting: typealias P = Parsers in callers
public enum Parsers {}

public struct Parser<A> {
    public let parse: (inout Substring) -> A?
}

public extension Parser {
    func run(_ string: String) -> (match: A?, rest: Substring) {
        var s = string[...]
        let result = parse(&s)
        return (result, s)
    }
}

public extension Parser {
    var never: Parser { Parser { _ in nil } }
}

func always<A>(_ a: A) -> Parser<A> {
    Parser<A> { _ in a }
}
