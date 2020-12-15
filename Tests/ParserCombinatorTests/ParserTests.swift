//
//  File.swift
//
//
//  Created by Griff on 12/14/20.
//

import ParserCombinator
import XCTest

final class ParserTests: XCTestCase {
    typealias P = Parsers

    func testInteger() {
        XCTAssertEqual(P.digit.run("123"), "1")
        XCTAssertEqual(P.integer.run("123"), 123)
    }

    func testComponents() {
        XCTAssertEqual(P.integer.run("1"), 1)
        XCTAssertEqual(P.character("-").run("-"), "-")
        XCTAssertEqual(P.integer.run("4"), 4)
        XCTAssertEqual(P.character(" ").run(" "), " ")
        XCTAssertEqual(P.letter.run("m"), "m")
    }
}
