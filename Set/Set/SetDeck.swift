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
    var alreadyfind = false
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
        
        //shuffle
        cards.shuffle()

        
        for index in 0...11{
            cardsOnDeck.append(cards.remove(at: 0))
        }
    }
    
    func chooseCard(at index: Int){
        //如果选到了没有牌的桌面
        if(index >= cardsOnDeck.count){
            return
        }
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
                    for i in 0...2{
                        chosenCards[i].chosen = false
                    }
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
        if _color != 0, _color != 3, _color != -3{
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
                    cardsOnDeck.remove(at: index)
                    break
                }
            }
            for index in cardsOnDeck.indices{
                if(cardsOnDeck[index].matched == 1){
                    cardsOnDeck.remove(at: index)
                    break
                }
            }
            for index in cardsOnDeck.indices{
                if(cardsOnDeck[index].matched == 1){
                    cardsOnDeck.remove(at: index)
                    break
                }
            }
        }
        alreadyfind = false
        chosenCards.removeAll()
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
    
    func find() -> Bool{
        if(alreadyfind == true)
        {
            return false
        }
        for i in 0...cardsOnDeck.count-1{
            if(i == cardsOnDeck.count-2){
                break
            }
            for j in i+1...cardsOnDeck.count-1{
                if(j == cardsOnDeck.count-1){
                    break
                }
                for k in j+1...cardsOnDeck.count-1{
                    if(checkInFind(card_a: i, card_b: j, card_c: k)){
                        cardsOnDeck[i] .chosen = true
                        cardsOnDeck[j] .chosen = true
                        cardsOnDeck[k] .chosen = true
                        cardsOnDeck[i] .matched = 1
                        cardsOnDeck[j] .matched = 1
                        cardsOnDeck[k] .matched = 1
                        chosenCards.append(cardsOnDeck[i])
                        chosenCards.append(cardsOnDeck[j])
                        chosenCards.append(cardsOnDeck[k])
                        alreadyfind = true
                        return true
                    }
                }
            }
        }
        return false
    }
    func checkInFind(card_a:Int, card_b:Int, card_c:Int) -> Bool{
        var __shape = 0, __color = 0, __border = 0, __number = 0
        __shape += cardsOnDeck[card_a].shape + cardsOnDeck[card_b].shape + cardsOnDeck[card_c].shape
        __color += cardsOnDeck[card_a].color + cardsOnDeck[card_b].color + cardsOnDeck[card_c].color
        __border += cardsOnDeck[card_a].border + cardsOnDeck[card_b].border + cardsOnDeck[card_c].border
        __number += cardsOnDeck[card_a].number + cardsOnDeck[card_b].number + cardsOnDeck[card_c].number

        if __shape != 0, __shape != 3, __shape != -3{
            
            return false
        }
        if __color != 0, __color != 3, __color != -3{
            
            return false
        }
        if __border != 0, __border != 3, __border != -3{
            
            return false
        }
        if __number != 0, __number != 3, __number != -3{
            
            return false
        }
        
        return true
    }
}

extension Array{
    mutating func shuffle(){
        for i in 0..<(count-1){
            let j = Int(arc4random_uniform(UInt32(count-i)))+i
            self.swapAt(i, j)
//            swap(&self[i], &self[j])
            
        }
    }
}
