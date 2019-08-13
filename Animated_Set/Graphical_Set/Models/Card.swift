//
//  Card.swift
//  Graphical_Set
//
//  Created by 汤佳桦 on 2019/7/30.
//  Copyright © 2019 Beijing Institute of Technology. All rights reserved.
//

import Foundation
struct Card
{
    var color: Color
    var number: Number
    var shape: Shape
    var fill: Fill
    
    enum Color: String{
        case red
        case green
        case purple
        
        static let all = [Color.red, .green, .purple]
    }
    
    enum Number: Int{
        case one = 1
        case two = 2
        case three = 3
        
        static let all = [Number.one, .two, .three]
    }
    
    enum Shape: String{
        case circle
        case square
        case triangle
        
        static let all = [Shape.circle, .square, .triangle]
    }
    
    enum Fill: String{
        case solid
        case stripe
        case empty
        
        static let all = [Fill.solid, .stripe, .empty]
    }
    
    init(_ c:Color, _ n: Number, _ s: Shape, _ f: Fill){
        color = c
        number = n
        shape = s
        fill = f
    }
}

extension Card: Equatable{
    static func ==(lhs: Card, rhs: Card) -> Bool{
        if (lhs.color == rhs.color
        && lhs.number == rhs.number
        && lhs.shape == rhs.shape
        && lhs.fill == rhs.fill){
            return true
        }
        
        return false
    }
}
