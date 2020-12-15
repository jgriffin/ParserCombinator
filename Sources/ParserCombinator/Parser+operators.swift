//
//  Parser+operators.swift
//
//
//  Created by Griff on 12/14/20.
//

import Foundation

public func curry<A, R>(_ f: @escaping (A) -> R) -> (A) -> R {
    { a in f(a) }
}

public func curry<A, B, R>(_ f: @escaping (A, B) -> R) -> (A) -> (B) -> R {
    { a in { b in f(a, b) } }
}

public func curry<A, B, C, R>(_ f: @escaping (A, B, C) -> R) -> (A) -> (B) -> (C) -> R {
    { a in { b in { c in f(a, b, c) } } }
}

public func curry<A, B, C, D, R>(_ f: @escaping (A, B, C, D) -> R) -> (A) -> (B) -> (C) -> (D) -> R {
    { a in { b in { c in { d in f(a, b, c, d) } } } }
}

// MARK: - operators

precedencegroup ApplyGroup {
    associativity: left
    higherThan: ComparisonPrecedence
}

precedencegroup FlatMapGroup {
    higherThan: ApplyGroup
    associativity: left
}

precedencegroup MapApplyGroup {
    higherThan: FlatMapGroup
    associativity: left
}

infix operator >>-: FlatMapGroup

infix operator <^>: MapApplyGroup
infix operator <*>: MapApplyGroup
infix operator <*: MapApplyGroup
infix operator *>: MapApplyGroup

// MARK: - >>- flat map

public func >>- <A, B>(p: Parser<A>,
                       f: @escaping (A) -> Parser<B>) -> Parser<B>
{
    .init { input in
        guard let (result, rest) = p.parse(input) else {
            return nil
        }

        return f(result).parse(rest)
    }
}

// MARK: - <^> map function

public func <^> <A, B>(lhs: @escaping (A) -> B,
                       rhs: Parser<A>) -> Parser<B>
{
    rhs.map(lhs)
}

public func <^> <A, B>(lhs: @escaping (A) -> B?,
                       rhs: Parser<A>) -> Parser<B>
{
    rhs.map(lhs)
}

// MARK: - <*> map parser

public func <*> <A, B>(lhs: Parser<(A) -> B>,
                       rhs: Parser<A>) -> Parser<B>
{
    lhs.followed(by: rhs).map { f, x in f(x) }
}

public func <* <A, B>(p1: Parser<A>, p2: Parser<B>) -> Parser<A> {
    { x in { _ in x } } <^> p1 <*> p2
}

public func *> <A, B>(p1: Parser<A>, p2: Parser<B>) -> Parser<B> {
    { _ in { x in x } } <^> p1 <*> p2
}

// MARK: - tupple

public func tuple<A, B>(_ a: A) -> (B) -> (A, B) {
    return { b in
        (a, b)
    }
}

public func tuple<A, B, C>(_ a: A) -> (B) -> (C) -> (A, B, C) {
    return { b in { c in (a, b, c) }
    }
}

public func tuple<A, B, C, D>(_ a: A) -> (B) -> (C) -> (D) -> (A, B, C, D) {
    return { b in { c in { d in (a, b, c, d) } } }
}

public func tuple<A, B, C, D, E>(_ a: A) -> (B) -> (C) -> (D) -> (E) -> (A, B, C, D, E) {
    return { b in { c in { d in { e in (a, b, c, d, e) } } } }
}
