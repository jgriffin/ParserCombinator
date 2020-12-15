//
//  ParserError.swift
//
//
//  Created by Griff on 12/14/20.
//

import Foundation

enum ParserError: Error {
    case conditionNotMet
    case noMatches
    case transformFailed
}
