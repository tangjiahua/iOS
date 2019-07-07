//
//  Concentration .swift
//  Concentration
//
//  Created by 汤佳桦 on 2019/6/29.
//  Copyright © 2019 BIT. All rights reserved.
//

import Foundation
//a model independent ui
class Concentration{
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int?{
        get {
            var foundIndex: Int?
            for index in cards.indices{
                if(cards[index].isFaceup){
                    if foundIndex == nil {
                        foundIndex = index
                    }else{ return nil}
                 }
            }
            return foundIndex
        }
        set{
            for index in cards.indices{
                cards[index].isFaceup = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int){
        
        if !cards[index].isMactched{
            assert(cards.indices.contains(index), "Concentration.chooseCard: chosen index not in the cards")
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                //check if cards match
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMactched = true
                    cards[index].isMactched = true
                }
                cards[index].isFaceup = true
            }else{
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card, card]
        }
        
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
