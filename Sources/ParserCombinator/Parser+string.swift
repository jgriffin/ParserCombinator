//
//  Parser+string.swift
//
//
//  Created by Griff on 12/20/20.
//

import Foundation

public protocol ParserStringConvertable {
    var asString: String? { get }
}

public extension ParserStringConvertable {
    var asInt: Int? {
        guard let string = asString else { return nil }
        return Int(string)
    }
}

extension String: ParserStringConvertable {
    public var asString: String? { self }
}

extension Substring: ParserStringConvertable {
    public var asString: String? { String(self) }
}

extension Array: ParserStringConvertable where Element == Character {
    public var asString: String? { String(self) }
}

public extension Parser where OUTPUT: ParserStringConvertable {
    var asString: Parser<String> {
        compactMap(\.asString)
    }

    var asInt: Parser<Int> {
        compactMap(\.asInt)
    }
}

// MARK: literal

public extension Parser where OUTPUT: StringProtocol {
    static func literal(_ literal: OUTPUT) -> Parser<OUTPUT> {
        Self { string in
            guard string.starts(with: literal) else { return nil }
            string.removeFirst(literal.count)
            return literal
        }
    }
}

extension Parser: ExpressibleByStringLiteral where OUTPUT == String {
    public typealias StringLiteralType = OUTPUT

    public init(stringLiteral value: OUTPUT) {
        self = Parser.literal(value)
    }
}

extension Parser: ExpressibleByExtendedGraphemeClusterLiteral where OUTPUT == String {
    public typealias ExtendedGraphemeClusterLiteralType = OUTPUT
}

extension Parser: ExpressibleByUnicodeScalarLiteral where OUTPUT == String {
    public typealias UnicodeScalarLiteralType = OUTPUT
}
