//
//  Parser.swift
//
//
//  Created by Griff on 12/14/20.
//

import Foundation

// MARK: oneOf

public extension Parser {
    // oneOf - takes the first ps that matches
    static func oneOf(_ ps: Parser<OUTPUT>...) -> Self {
        Parser<OUTPUT> { string in
            for p in ps {
                if let match = p.parse(&string) {
                    return match
                }
            }
            return nil
        }
    }
}

// FUTURE:
// compactMap:  ((A) -> B?) -> (Parser<A>) -> Parser<B>
// filter:      ((A) -> Bool) -> (Parser<A>) -> Parser<B>
// either:      ((A) -> Either<B, C>) -> (Parser<A>) -> Parser<Either<B, C>>
