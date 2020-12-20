//
//  Parser.swift
//
//
//  Created by Griff on 12/14/20.
//

import Foundation

public extension Parsers {
    static func take<A, S>(minCount: Int = 0,
                           count maxCount: Int = Int.max,
                           _ p: Parser<A>,
                           separatedBy s: Parser<S>) -> Parser<[A]>
    {
        Parser<[A]> { string in
            let original = string

            var matches: [A] = []

            while matches.count < maxCount,
                  let match = p.parse(&string)
            {
                matches.append(match)

                let backtrack = string
                guard let _ = s.parse(&string) else {
                    string = backtrack
                    break
                }
            }

            guard minCount <= matches.count else {
                string = original
                return nil
            }

            return matches
        }
    }

    // MARK: zeroOrMore

    static func zeroOrMore<A>(_ p: Parser<A>) -> Parser<[A]> {
        Parser<[A]> { string in
            var matches: [A] = []
            while let match = p.parse(&string) {
                matches.append(match)
            }
            return matches
        }
    }

    static func zeroOrMore<A, S>(_ p: Parser<A>,
                                 separatedBy s: Parser<S>) -> Parser<[A]>
    {
        Parser<[A]> { string in
            var backtrack = string
            var matches: [A] = []
            while let match = p.parse(&string) {
                backtrack = string
                matches.append(match)
                guard let _ = s.parse(&string) else {
                    return matches
                }
            }
            string = backtrack
            return matches
        }
    }

    // MARK: oneOrMore

    static func oneOrMore<A>(_ p: Parser<A>) -> Parser<[A]> {
        Parser<[A]> { string in
            let original = string
            guard let result = zeroOrMore(p).parse(&string),
                  !result.isEmpty
            else {
                string = original
                return nil
            }
            return result
        }
    }

    static func oneOrMore<A, S>(_ p: Parser<A>,
                                separatedBy s: Parser<S>) -> Parser<[A]>
    {
        Parser<[A]> { string in
            let original = string
            guard let result = zeroOrMore(p, separatedBy: s).parse(&string),
                  !result.isEmpty
            else {
                string = original
                return nil
            }
            return result
        }
    }

    // MARK: oneOf

    static func oneOf<A>(_ ps: [Parser<A>]) -> Parser<A> {
        Parser<A> { string in
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
