//
//  File.swift
//
//
//  Created by Griff on 12/21/20.
//

import Foundation

public enum Either<A, B> {
    case a(A), b(B)
}

public enum Either3<A, B, C> {
    case a(A), b(B), c(C)
}

public enum Either4<A, B, C, D> {
    case a(A), b(B), c(C), d(D)
}

// either: (OUPUT) -> Either<A,B>? -> Parser<A,B>
public func either<A, B>(_ pa: Parser<A>,
                         _ pb: Parser<B>)
    -> Parser<Either<A, B>>
{
    Parser<Either<A, B>> { input in
        if let resultA = pa.parse(&input) { return .a(resultA) }
        if let resultB = pb.parse(&input) { return .b(resultB) }
        return nil
    }
}

// either: (OUPUT) -> Either<A,B,C>? -> Parser<A,B,C>
public func either<A, B, C>(_ pa: Parser<A>,
                            _ pb: Parser<B>,
                            _ pc: Parser<C>)
    -> Parser<Either3<A, B, C>>
{
    Parser<Either3<A, B, C>> { input in
        if let resultA = pa.parse(&input) { return .a(resultA) }
        if let resultB = pb.parse(&input) { return .b(resultB) }
        if let resultC = pc.parse(&input) { return .c(resultC) }
        return nil
    }
}

// either: (OUPUT) -> Either<A,B,C,D>? -> Parser<A,B,C,D>
public func either<A, B, C, D>(_ pa: Parser<A>,
                               _ pb: Parser<B>,
                               _ pc: Parser<C>,
                               _ pd: Parser<D>)
    -> Parser<Either4<A, B, C, D>>
{
    Parser<Either4<A, B, C, D>> { input in
        if let resultA = pa.parse(&input) { return .a(resultA) }
        if let resultB = pb.parse(&input) { return .b(resultB) }
        if let resultC = pc.parse(&input) { return .c(resultC) }
        if let resultD = pd.parse(&input) { return .d(resultD) }
        return nil
    }
}
