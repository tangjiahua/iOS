//
//  SetDeck.swift
//  Set
//
//  Created by 汤佳桦 on 2019/7/11.
//  Copyright © 2019 Beijing Institute of Technology. All rights reserved.
//

import Foundation
class SetDeck{
    var cards = [Card]()
    var cardsOnDeck = [Card]()
    var chosenCards = [Card]()
    
    static var selected = 0
    
    init() {
        for shape in [-1, 0, 1]{
            for color in [-1, 0, 1]{
                for border in [-1, 0, 1]{
                    for number in [-1, 0, 1]{
                        let card = Card(shape: shape, color: color, border: border, number: number)
                        cards.append(card)
                    }
                }
            }
        }
        for index in 0...11{
            cardsOnDeck.append(cards.remove(at: 0))
        }
    }
    
    func chooseCard(at index: Int){
        //桌上的牌没被选
        if(!cardsOnDeck[index].chosen){
            if(chosenCards.count == 3){
                for chosenIndex in 0...2{
                    for currentIndex in cardsOnDeck.indices{
                        if(cardsOnDeck[currentIndex] == chosenCards[chosenIndex]){
                            cardsOnDeck[currentIndex].chosen = false
                        }
                    }
                }
                for _ in 0...2{
                    chosenCards.remove(at: 0)
                }
                cardsOnDeck[index] .chosen = true
                chosenCards.append(cardsOnDeck[index])
            }
            else{
                cardsOnDeck[index].chosen = true
                //SetDeck.selected += 1
                chosenCards.append(cardsOnDeck[index])
            }
            
        }
            //桌上的牌已经被选了
        else{
            cardsOnDeck[index].chosen = false
            //SetDeck.selected -= 1
            for movingIndex in chosenCards.indices{
                if(chosenCards[movingIndex] == cardsOnDeck[index]){
                    chosenCards.remove(at: movingIndex)
                    break
                }
            }
            
        }
    }
    
    func check() -> Bool{
        var _shape = 0, _color = 0, _border = 0, _number = 0
        for index in 0...2{
            _shape += chosenCards[index].shape
            _color += chosenCards[index].color
            _border += chosenCards[index].border
            _number += chosenCards[index].number
        }
        if _shape != 0, _shape != 3, _shape != -3{
            chosenCards[0].matched = -1
            chosenCards[1].matched = -1
            chosenCards[2].matched = -1
            return false
        }
        if _color != 0, _shape != 3, _shape != -3{
            chosenCards[0].matched = -1
            chosenCards[1].matched = -1
            chosenCards[2].matched = -1
            return false
        }
        if _border != 0, _border != 3, _border != -3{
            chosenCards[0].matched = -1
            chosenCards[1].matched = -1
            chosenCards[2].matched = -1
            return false
        }
        if _number != 0, _number != 3, _number != -3{
            chosenCards[0].matched = -1
            chosenCards[1].matched = -1
            chosenCards[2].matched = -1
            return false
        }
        chosenCards[0].matched = 1
        chosenCards[1].matched = 1
        chosenCards[2].matched = 1
        return true
    }
    
    func replace(){
        if(cards.count != 0){
            for index in cardsOnDeck.indices{
                if(cardsOnDeck[index].matched == 1){
                    cardsOnDeck[index] = (cards.remove(at: 0))
                }
            }
        }
        else{
            for index in cardsOnDeck.indices{
                if(cardsOnDeck[index].matched == 1){
                    cardsOnDeck[index].hide = true
                }
            }
        }
    }
    
    func add(){
        if(cards.count > 0){
            for _ in 1...3{cardsOnDeck.append(cards.remove(at: 0))}
        }
    }
    
    func reset(){
        for index in cardsOnDeck.indices{
            cardsOnDeck[index].matched = 0
        }
    }
}

