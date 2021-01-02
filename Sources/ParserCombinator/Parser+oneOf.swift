//
//  Parser.swift
//
//
//  Created by Griff on 12/14/20.
//

import Foundation

// MARK: oneOf

// oneOf - takes the first ps that matches
public func oneOf<S: Sequence, A>(_ ps: S) -> Parser<A> where S.Element == Parser<A> {
    Parser<A> { input in
        for p in ps {
            if let match = p.parse(&input) {
                return match
            }
        }
        return nil
    }
}

public func oneOf<A>(_ ps: Parser<A>...) -> Parser<A> {
    oneOf(ps)
}
