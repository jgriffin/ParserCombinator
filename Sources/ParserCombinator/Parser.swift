//
//  Parser.swift
//
//
//  Created by Griff on 12/14/20.
//

import Foundation

public struct Parser<Result> {
    public typealias Stream = Substring
    public let parse: (Stream) -> (result: Result, remain: Stream)?
}

public extension Parser {
    func run(_ input: Substring) -> Result? {
        parse(input)?.result
    }

    func run(_ string: String) -> Result? {
        run(string[...])
    }
}

public extension Parser {
    func zeroOrMore() -> Parser<[Result]> {
        .init { input in
            var result = [Result]()
            var rest = input

            while let (element, newRest) = parse(rest) {
                result.append(element)
                rest = newRest
            }

            return (result, rest)
        }
    }

    func oneOrMore() -> Parser<[Result]> {
        .init { input in
            guard let (result, remain) = zeroOrMore().parse(input),
                  !result.isEmpty
            else {
                return nil
            }
            return (result, remain)
        }
    }
}

public extension Parser {
    func map<T>(_ transform: @escaping (Result) -> T) -> Parser<T> {
        .init { input in
            parse(input)
                .map { (transform($0.result), $0.remain) }
        }
    }

    func map<T>(_ transform: @escaping (Result) -> T?) -> Parser<T> {
        .init { input in
            guard let (result, remain) = parse(input),
                  let transformed = transform(result)
            else {
                return nil
            }
            return (transformed, remain)
        }
    }

    func followed<B>(by other: Parser<B>) -> Parser<(Result, B)> {
        .init { input in
            guard let (result1, remainder1) = self.parse(input),
                  let (result2, remainder2) = other.parse(remainder1)
            else {
                return nil
            }
            return ((result1, result2), remainder2)
        }
    }
}
