//
//  File.swift
//
//
//  Created by Griff on 12/14/20.
//

import ParserCombinator
import XCTest

final class ParserTests: XCTestCase {
    typealias P = Parser

    func testInteger() {
        XCTAssertEqual(P.digit.run("123").match, "1")
        XCTAssertEqual(P.integer.run("123").match, 123)
    }

    func testComponents() {
        XCTAssertEqual(P.integer.run("1").match, 1)
        XCTAssertEqual(P.character("-").run("-").match, "-")
        XCTAssertEqual(P.integer.run("4").match, 4)
        XCTAssertEqual(P.character(" ").run(" ").match, " ")
        XCTAssertEqual(P.letter.run("m").match, "m")
    }

    func testZip() {
        let test = "123"

        let result = zip(
            P.character("1"),
            P.character("2"),
            P.character("3")
        )
        .map { [$0.0, $0.1, $0.2] }
        .run(test).match

        XCTAssertEqual(result, ["1", "2", "3"])
    }
}
