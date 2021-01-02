//
//  File.swift
//
//
//  Created by Griff on 1/1/21.
//

import Foundation

public func sequence<S: Sequence, A>(_ ps: S) -> Parser<[A]> where S.Element == Parser<A> {
    Parser<[A]> { input in
        let original = input

        var output = [A]()

        for p in ps {
            guard let match = p.parse(&input) else {
                input = original
                return nil
            }
            output.append(match)
        }

        return output
    }
}
