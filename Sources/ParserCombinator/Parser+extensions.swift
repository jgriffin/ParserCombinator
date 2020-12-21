//
//  Parsers.swift
//
//
//  Created by Griff on 12/14/20.
//

import Foundation

public extension Parser {
    var never: Self { Self { _ in nil } }

    func always(_ a: OUTPUT) -> Self { Self { _ in a } }
}

public extension Parser where OUTPUT == Character {
    static let nextChar = Self { string in
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

    static func character(_ ch: Character) -> Self {
        character { $0 == ch }
    }

    static func character(in characterSet: CharacterSet) -> Self {
        character { ch in characterSet.contains(ch.unicodeScalar) }
    }

    static let letter = character(in: .letters)
    static let digit = character(in: .decimalDigits)
    static let alphanum = character(in: .alphanumerics)
    static let space = character(" ")
    static let newline = character("\n")
}

public extension Parser where OUTPUT == Substring {
    static func prefix(while predicate: @escaping (Character) -> Bool) -> Self {
        Parser<Substring> { string in
            let prefix = string.prefix(while: predicate)
            string.removeFirst(prefix.count)
            return prefix
        }
    }

    static func prefix(charactersIn characterSet: CharacterSet) -> Self {
        Parser<Substring>.prefix(while: { ch in
            characterSet.contains(ch.unicodeScalar)
        })
    }

    var string: Parser<String> {
        compactMap { String($0) }
    }

    var int: Parser<Int> {
        string.compactMap { Int($0) }
    }
}

public extension Parser where OUTPUT == Void {
    static func literal(_ literal: String) -> Parser<Void> {
        Parser<Void> { string in
            guard string.hasPrefix(literal) else { return nil }
            string.removeFirst(literal.count)
            return ()
        }
    }
}

public extension Parser where OUTPUT == String {
    static let letters = Parser<Substring>.prefix(charactersIn: .letters).string
    static let alphanums = Parser<Substring>.prefix(charactersIn: .alphanumerics).string
    static let spaces = Parser<Substring>.prefix { $0 == " " }.string
}

public extension Parser where OUTPUT == Int {
    static let integer = Parser<Substring>.prefix(charactersIn: .decimalDigits).int
}
