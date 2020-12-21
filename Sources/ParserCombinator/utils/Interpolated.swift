//
//  Interpolated.swift
//
//
//  Created by Griff on 12/21/20.
//

import Foundation

// MARK: interpolated

// while debugging, we often want to print(match),
// but the compiler doesn't like optionals or implicy Any casts
// .interpolated gets around those issues
public extension CustomStringConvertible {
    var interpolated: String {
        "\(self)"
    }
}

public extension Optional where Wrapped: CustomStringConvertible {
    var interpolated: String {
        guard let value = self else { return "nil" }
        return value.interpolated
    }
}

public protocol InterpolableCollection {
    var interpolated: String { get }
    var interpolatedLines: String { get }
}

extension Array: InterpolableCollection where Element: CustomStringConvertible {
    public var interpolated: String {
        map(\.interpolated).joined(separator: ", ")
    }

    public var interpolatedLines: String {
        map(\.interpolated).joined(separator: "\n")
    }
}

public extension Optional where Wrapped: InterpolableCollection {
    var interpolated: String {
        guard let value = self else { return "nil" }
        return value.interpolated
    }

    var interpolatedLines: String {
        guard let value = self else { return "nil" }
        return value.interpolatedLines
    }
}
