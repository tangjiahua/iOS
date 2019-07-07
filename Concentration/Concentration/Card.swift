//
//  Card.swift
//  Concentration
//
//  Created by 汤佳桦 on 2019/6/29.
//  Copyright © 2019 BIT. All rights reserved.
//

import Foundation
//No inherit
//Are value types, provide copy; class is reference type,pointers, stacks
struct Card: Hashable{
    var isFaceup = false
    var isMactched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int{
        identifierFactory += 1//because of static identifierfactory
        return Card.identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
