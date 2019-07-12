//
//  Card.swift
//  Set
//
//  Created by 汤佳桦 on 2019/7/11.
//  Copyright © 2019 Beijing Institute of Technology. All rights reserved.
//

import Foundation
class Card: CustomStringConvertible{
    var description: String{return "\(shape)\(color)\(border)\(number)"}
    //牌的自身属性
    var shape: Int
    var color: Int
    var border: Int
    var number: Int
    //牌的控制属性
    var chosen = false
    var matched: Int
    var hide = false
    
    var identifier: Int
    private static var identifierFactor = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactor += 1
        return identifierFactor
    }
    
    
    init(shape: Int, color: Int, border: Int, number: Int) {
        self.identifier = Card.getUniqueIdentifier()
        self.shape = shape
        self.color = color
        self.border = border
        self.number = number
        self.matched = 0
    }
}
extension Card: Hashable {
    
    var hashValue: Int {
        return identifier
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
