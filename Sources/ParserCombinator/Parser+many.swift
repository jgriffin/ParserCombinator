//
//  Parser.swift
//
//
//  Created by Griff on 12/14/20.
//

import Foundation

public extension Parser {
    // MARK: takeMany

    func takeMany(minCount: Int = 0,
                  maxCount: Int = Int.max)
        -> Parser<[OUTPUT]>
    {
        Parser<[OUTPUT]> { string in
            let original = string

            var matches: [OUTPUT] = []

            while matches.count < maxCount,
                  let match = parse(&string)
            {
                matches.append(match)
            }

            guard minCount <= matches.count
            else {
                string = original
                return nil
            }

            return matches
        }
    }

    func takeMany<S>(minCount: Int = 0,
                     maxCount: Int = Int.max,
                     separatedBy s: Parser<S>)
        -> Parser<[OUTPUT]>
    {
        Parser<[OUTPUT]> { string in
            let original = string

            var matches: [OUTPUT] = []

            while matches.count < maxCount,
                  let match = parse(&string)
            {
                matches.append(match)

                let backtrack = string
                guard let _ = s.parse(&string)
                else {
                    string = backtrack
                    break
                }
            }

            guard minCount <= matches.count
            else {
                string = original
                return nil
            }

            return matches
        }
    }

    // MARK: zeroOrMore

    func zeroOrMore()
        -> Parser<[OUTPUT]> { takeMany(minCount: 0, maxCount: Int.max) }

    func zeroOrMore<S>(separatedBy s: Parser<S>)
        -> Parser<[OUTPUT]>
    { takeMany(minCount: 0, maxCount: Int.max, separatedBy: s) }

    // MARK: oneOrMore

    func oneOrMore()
        -> Parser<[OUTPUT]>
    { takeMany(minCount: 1, maxCount: Int.max) }

    func oneOrMore<S>(separatedBy s: Parser<S>)
        -> Parser<[OUTPUT]>
    { takeMany(minCount: 1, maxCount: Int.max, separatedBy: s) }

    // MARK: takeCount

    func takeCount(_ count: Int)
        -> Parser<[OUTPUT]>
    { takeMany(minCount: count, maxCount: count) }

    func takeCount<S>(_ count: Int, separatedBy s: Parser<S>)
        -> Parser<[OUTPUT]>
    { takeMany(minCount: count, maxCount: count, separatedBy: s) }
}

// FUTURE:
// compactMap:  ((A) -> B?) -> (Parser<A>) -> Parser<B>
// filter:      ((A) -> Bool) -> (Parser<A>) -> Parser<B>
// either:      ((A) -> Either<B, C>) -> (Parser<A>) -> Parser<Either<B, C>>
