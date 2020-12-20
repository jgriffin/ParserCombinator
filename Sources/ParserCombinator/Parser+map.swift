//
//  Parser.swift
//
//
//  Created by Griff on 12/14/20.
//

import Foundation

public extension Parser {
    // map: ((A) -> B) -> (F<A>) -> F<B>
    // map: ((A) -> B) -> (Parser<A>) -> Parser<B>
    func map<B>(_ f: @escaping (A) -> B) -> Parser<B> {
        Parser<B> { string -> B? in
            let matchA = parse(&string)
            let matchB = matchA.map(f)
            return matchB
        }
    }

    func compactMap<B>(_ f: @escaping (A) -> B?) -> Parser<B> {
        Parser<B> { string -> B? in
            let matchA = parse(&string)
            let matchB = matchA.flatMap(f)
            return matchB
        }
    }

    // flatMap: ((A) -> M<B>) -> (M<A>) -> M<B>
    func flatMap<B>(_ f: @escaping (A) -> Parser<B>) -> Parser<B> {
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
