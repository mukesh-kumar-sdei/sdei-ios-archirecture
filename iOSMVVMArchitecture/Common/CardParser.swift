//
//  CardParser.swift
//  Maticy
//
//  Created by Amit Shukla on 04/03/20.
//  Copyright © 2020 Maticy. All rights reserved.
//

//3X= Amex
//▪    4X= Visa
//▪    5X= Mastercard
//▪    6X= Discover
// https://kalapun.com/posts/card-checking-in-swift/
import Foundation

extension StringProtocol {
    subscript(_ offset: Int)                     -> Element     { self[index(startIndex, offsetBy: offset)] }
    subscript(_ range: Range<Int>)               -> SubSequence { prefix(range.lowerBound+range.count).suffix(range.count) }
    subscript(_ range: ClosedRange<Int>)         -> SubSequence { prefix(range.lowerBound+range.count).suffix(range.count) }
    subscript(_ range: PartialRangeThrough<Int>) -> SubSequence { prefix(range.upperBound.advanced(by: 1)) }
    subscript(_ range: PartialRangeUpTo<Int>)    -> SubSequence { prefix(range.upperBound) }
    subscript(_ range: PartialRangeFrom<Int>)    -> SubSequence { suffix(Swift.max(0, count-range.lowerBound)) }
}
extension LosslessStringConvertible {
    var string: String { .init(self) }
}
extension BidirectionalCollection {
    subscript(safe offset: Int) -> Element? {
        guard !isEmpty, let i = index(startIndex, offsetBy: offset, limitedBy: index(before: endIndex)) else { return nil }
        return self[i]
    }
}

enum CardType: String {
    case Unknown, Amex, Visa, MasterCard, Discover

}

class CardParser {
    
    static func checkCard(with token: String) -> CardType {
        if token.count < 16 {
            return .Unknown
        }
        
        let c = token[1]
        switch c {
        case "3":
            return .Amex
        case "4":
            return .Visa
        case "5":
            return .MasterCard
        case "6":
            return .Discover
        default:
            return .Unknown
        }
    }
    
}
