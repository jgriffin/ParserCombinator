//
//  Parsers.swift
//
//
//  Created by Griff on 12/14/20.
//

import Foundation

public enum Parsers {}

public extension Parsers {
    static func passing(_ check: @escaping (Character) -> Bool) -> Parser<Character> {
        .init { input in
            guard let ch = input.first, check(ch) else {
                return nil
            }
            return (ch, input.dropFirst())
        }
    }

    static let letter = Self.passing { CharacterSet.letters.contains($0.unicodeScalar) }
    static let word = letter.oneOrMore().map { characters in String(characters) }

    static let digit = Self.passing { CharacterSet.decimalDigits.contains($0.unicodeScalar) }
    static let integer = digit.oneOrMore().map { characters in Int(String(characters)) }
}

public extension Parsers {
    static func character(_ ch: Character) -> Parser<Character> {
        passing { $0 == ch }
    }

    static func string(_ prefix: String) -> Parser<String> {
        .init { input in
            guard input.hasPrefix(prefix) else { return nil }
            return (prefix, input.dropFirst(prefix.count))
        }
    }
}
