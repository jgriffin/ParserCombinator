//
//  Parsers.swift
//
//
//  Created by Griff on 12/14/20.
//

import Foundation

public extension Parsers {
    static let nextChar = Parser<Character> { string in
        guard !string.isEmpty else { return nil }
        return string.removeFirst()
    }

    static func character(if predicate: @escaping (Character) -> Bool) -> Parser<Character> {
        Parser<Character> { string in
            let original = string
            guard let ch = nextChar.parse(&string),
                  predicate(ch)
            else {
                string = original
                return nil
            }
            return ch
        }
    }

    static func character(_ ch: Character) -> Parser<Character> {
        character { $0 == ch }
    }

    static func character(in characterSet: CharacterSet) -> Parser<Character> {
        character { ch in characterSet.contains(ch.unicodeScalar) }
    }

    static func prefix(charactersIn characterSet: CharacterSet) -> Parser<[Character]> {
        prefix(while: { ch in characterSet.contains(ch.unicodeScalar) })
            .map(Array.init)
    }

    static func prefix(while predicate: @escaping (Character) -> Bool) -> Parser<Substring> {
        Parser<Substring> { string in
            let prefix = string.prefix(while: predicate)
            string.removeFirst(prefix.count)
            return prefix
        }
    }

    static func literal(_ literal: String) -> Parser<Void> {
        Parser<Void> { string in
            guard string.hasPrefix(literal) else { return nil }
            string.removeFirst(literal.count)
            return ()
        }
    }
}

public extension Parsers {
    static let letter = character(in: .letters)
    static let letters = prefix(charactersIn: .letters).string

    static let digit = character(in: .decimalDigits)
    static let integer = prefix(charactersIn: .decimalDigits).int

    static let alphanum = character(in: .alphanumerics)
    static let alphanums = prefix(charactersIn: .alphanumerics).string

    static let space = character(" ")
    static let spaces = prefix { $0 == " " }.string

    static let newline = character("\n")
}
