//
//  Parser.swift
//
//
//  Created by Griff on 12/14/20.
//

import Foundation

// MARK: oneOf

// oneOf - takes the first ps that matches
public func oneOf<A>(_ ps: Parser<A>...) -> Parser<A> {
    Parser<A> { string in
        for p in ps {
            if let match = p.parse(&string) {
                return match
            }
        }
        return nil
    }
}

// FUTURE:
// compactMap:  ((A) -> B?) -> (Parser<A>) -> Parser<B>
// filter:      ((A) -> Bool) -> (Parser<A>) -> Parser<B>
// either:      ((A) -> Either<B, C>) -> (Parser<A>) -> Parser<Either<B, C>>
