//
//  Parser.swift
//
//
//  Created by Griff on 12/14/20.
//

import Foundation

public extension Parser {
    // map: ((A) -> B) -> (Parser<A>) -> Parser<B>
    func map<B>(_ f: @escaping (OUTPUT) -> B) -> Parser<B> {
        Parser<B> { string -> B? in
            let matchA = parse(&string)
            let matchB = matchA.map(f)
            return matchB
        }
    }

    // compactMap: ((A) -> B?) -> (Parser<A>) -> Parser<B>)
    func compactMap<B>(_ f: @escaping (OUTPUT) -> B?) -> Parser<B> {
        Parser<B> { string -> B? in
            let matchA = parse(&string)
            let matchB = matchA.flatMap(f)
            return matchB
        }
    }

    // flatMap: ((A) -> Parser<B>) -> (Parser<A>) -> Parser<B>
    func flatMap<B>(_ f: @escaping (OUTPUT) -> Parser<B>) -> Parser<B> {
        Parser<B> { string in
            let original = string
            let matchA = parse(&string)
            let parserB = matchA.map(f)
            guard let matchB = parserB?.parse(&string) else {
                string = original
                return nil
            }
            return matchB
        }
    }
}

public extension Parser {
    // filter: ((A) -> Bool) -> (Parser<A>) -> Parser<B>
    func filter(_ f: @escaping (OUTPUT) -> Bool) -> Self {
        compactMap { a -> OUTPUT? in
            f(a) ? a : nil
        }
    }

    // either:      ((A) -> Either<B, C>) -> (Parser<A>) -> Parser<Either<B, C>>
}
