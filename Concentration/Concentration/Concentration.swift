//
//  Concentration.swift
//  Concentration
//
//  Created by jamfly on 2017/12/27.
//  Copyright © 2017年 jamfly. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    lazy var flipCount = 0
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    flipCount += 2
                }
                else{
                    if cards[index].FaceUped == true, cards[matchIndex].FaceUped == true{
                        flipCount -= 1
                    }
                }
                
                cards[index].isFaceUp = true
                
            } else {
                // either no card or two cards face up
                indexOfOneAndOnlyFaceUpCard = index
                
            }
            cards[index].FaceUped = true
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentraion.init(\(numberOfPairsOfCards)")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        //    TODO: Shuffle the cards
        //TODO
        var shuffle_x = 1, shuffle_y = 1
        var shuffle_Card = Card()
        for _ in 1...10{
            shuffle_x = Int(arc4random_uniform(UInt32(cards.count)))
            shuffle_y = Int(arc4random_uniform(UInt32(cards.count)))
            shuffle_Card = cards[shuffle_x]
            cards[shuffle_x] = cards[shuffle_y]
            cards[shuffle_y] = shuffle_Card
            
        }
    }
    
    
    
}











