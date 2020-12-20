//
//  Parser.swift
//
//
//  Created by Griff on 12/14/20.
//

import Foundation

public extension Parsers {
    // zip: (F<A>, F<B>) -> F<(A, B)>
    static func zip<A, B>(
        _ a: Parser<A>,
        _ b: Parser<B>
    ) -> Parser<(A, B)> {
        Parser<(A, B)> { string in
            let original = string
            guard let resultA = a.parse(&string),
                  let resultB = b.parse(&string)
            else {
                string = original
                return nil
            }
            return (resultA, resultB)
        }
    }

    static func zip<A, B, C>(
        _ a: Parser<A>,
        _ b: Parser<B>,
        _ c: Parser<C>
    ) -> Parser<(A, B, C)> {
        zip(a, zip(b, c))
            .map { a, bc in (a, bc.0, bc.1) }
    }

    static func zip<A, B, C, D>(
        _ a: Parser<A>,
        _ b: Parser<B>,
        _ c: Parser<C>,
        _ d: Parser<D>
    ) -> Parser<(A, B, C, D)> {
        zip(a, zip(b, c, d))
            .map { a, bcd in (a, bcd.0, bcd.1, bcd.2) }
    }

    static func zip<A, B, C, D, E>(
        _ a: Parser<A>,
        _ b: Parser<B>,
        _ c: Parser<C>,
        _ d: Parser<D>,
        _ e: Parser<E>
    ) -> Parser<(A, B, C, D, E)> {
        zip(a, zip(b, c, d, e))
            .map { a, rest in (a, rest.0, rest.1, rest.2, rest.3) }
    }

    static func zip<A, B, C, D, E, F>(
        _ a: Parser<A>,
        _ b: Parser<B>,
        _ c: Parser<C>,
        _ d: Parser<D>,
        _ e: Parser<E>,
        _ f: Parser<F>
    ) -> Parser<(A, B, C, D, E, F)> {
        zip(a, zip(b, c, d, e, f))
            .map { a, rest in (a, rest.0, rest.1, rest.2, rest.3, rest.4) }
    }

    static func zip<A, B, C, D, E, F, G>(
        _ a: Parser<A>,
        _ b: Parser<B>,
        _ c: Parser<C>,
        _ d: Parser<D>,
        _ e: Parser<E>,
        _ f: Parser<F>,
        _ g: Parser<G>
    ) -> Parser<(A, B, C, D, E, F, G)> {
        zip(a, zip(b, c, d, e, f, g))
            .map { a, rest in (a, rest.0, rest.1, rest.2, rest.3, rest.4, rest.5) }
    }

    static func zip<A, B, C, D, E, F, G, H>(
        _ a: Parser<A>,
        _ b: Parser<B>,
        _ c: Parser<C>,
        _ d: Parser<D>,
        _ e: Parser<E>,
        _ f: Parser<F>,
        _ g: Parser<G>,
        _ h: Parser<H>
    ) -> Parser<(A, B, C, D, E, F, G, H)> {
        zip(a, zip(b, c, d, e, f, g, h))
            .map { a, rest in (a, rest.0, rest.1, rest.2, rest.3, rest.4, rest.5, rest.6) }
    }

    static func zip<A, B, C, D, E, F, G, H, I>(
        _ a: Parser<A>,
        _ b: Parser<B>,
        _ c: Parser<C>,
        _ d: Parser<D>,
        _ e: Parser<E>,
        _ f: Parser<F>,
        _ g: Parser<G>,
        _ h: Parser<H>,
        _ i: Parser<I>
    ) -> Parser<(A, B, C, D, E, F, G, H, I)> {
        zip(a, zip(b, c, d, e, f, g, h, i))
            .map { a, rest in (a, rest.0, rest.1, rest.2, rest.3, rest.4, rest.5, rest.6, rest.7) }
    }

    static func zip<A, B, C, D, E, F, G, H, I, J>(
        _ a: Parser<A>,
        _ b: Parser<B>,
        _ c: Parser<C>,
        _ d: Parser<D>,
        _ e: Parser<E>,
        _ f: Parser<F>,
        _ g: Parser<G>,
        _ h: Parser<H>,
        _ i: Parser<I>,
        _ j: Parser<J>
    ) -> Parser<(A, B, C, D, E, F, G, H, I, J)> {
        zip(a, zip(b, c, d, e, f, g, h, i, j))
            .map { a, rest in (a, rest.0, rest.1, rest.2, rest.3, rest.4, rest.5, rest.6, rest.7, rest.8) }
    }
}
