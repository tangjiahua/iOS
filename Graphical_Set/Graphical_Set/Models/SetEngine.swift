//
//  SetEngine.swift
//  Graphical_Set
//
//  Created by 汤佳桦 on 2019/7/31.
//  Copyright © 2019 Beijing Institute of Technology. All rights reserved.
//

import Foundation
struct SetEngine{
    private(set) var deck = [Card]()
    private(set) var score = 0
    
    var numberOfCard: Int{
        return deck.count
    }
    
    private(set) var cardOnTable = [Card]()
    private(set) var selectedCard = [Card]()
    
    var hintCard = [Int]()
    
    //isSet()，传递进来的是一个card数组，并不是说一定是selectedcard，后面hint也用到了这个函数
    mutating func isSet(on selectedCard: [Card]) -> Bool{
        let color = Set(selectedCard.map{ $0.color}).count
        let shape = Set(selectedCard.map{ $0.shape }).count
        let number = Set(selectedCard.map{ $0.number }).count
        let fill = Set(selectedCard.map{ $0.fill }).count
        
        return color != 2 && shape != 2 && number != 2 && fill != 2
    }
    
    //draw()拿出牌堆里面的三张卡出来
    //draw是有可能返回空数组的
    mutating func draw() -> [Card]{
        if deck.count > 0{
            var drawCards = [Card]()
            for _ in 1...3{
                //deck中移除卡片，drawcards中添加卡片！
                drawCards.append(deck.remove(at: deck.randomIndex))
            }
            return drawCards
        }
        return []
    }
    
    mutating func chooseCard(at index: Int){
        //已经选过了正在选的这张卡要怎么处理
        if selectedCard.contains(cardOnTable[index]){
            selectedCard.remove(at: selectedCard.firstIndex(of: cardOnTable[index])!)
            return
        }
        selectedCard += [cardOnTable[index]]
        if selectedCard.count == 3{
            if isSet(on: selectedCard){
                let drawCard = draw()//从未放上桌面的卡堆里拿出3张卡出来放进drawCard数组中
                for index in selectedCard.indices{
                    let removeIndex = cardOnTable.firstIndex(of: selectedCard[index])!//removeiIndex是cardonTable上面被选择的卡片的Index
                    if(drawCard.count>0){
                        //更换卡牌
                        cardOnTable[removeIndex] = drawCard[index]
                    }else{
                        //如果没有可以更换的卡牌了，那么就直接移除cardOntable上的被选择的卡牌
                        cardOnTable.remove(at: removeIndex)
                    }
                }
                score += 1
            }else{
                score -= 1
            }
            
            selectedCard.removeAll()
        }
    }
    
    
    mutating func shuffle() {
        let number = cardOnTable.count / 3
        //把cardsonTable上面的卡全部放回deck中
        for cards in cardOnTable {
            deck.append(cards)
        }
        cardOnTable.removeAll()
        //从deck中取出3 *count的卡片出来放回，由于draw函数是random出来的，所以可以直接用
        for _ in 1...number {
            cardOnTable += draw()
        }
    }
    //点击hint🔘
    mutating func hint() -> Void{
        hintCard.removeAll()
        for i in 0..<cardOnTable.count {
            for j in (i + 1)..<cardOnTable.count {
                for k in (j + 1)..<cardOnTable.count {
                    let hints = [cardOnTable[i], cardOnTable[j], cardOnTable[k]]
                    if isSet(on: hints) {
                        hintCard += [i, j, k]
                        return
                    }
                }
            }
        }
    }
    //添加三张卡到牌桌cardontable上
    mutating func drawThreeToDeck() {
        let card = draw()
        for cards in card {
            cardOnTable.append(cards)
        }
    }
    
    //将所有卡牌放入deck中， 初始化完毕
    init() {
        for color in Card.Color.all {
            for number in Card.Number.all {
                for shape in Card.Shape.all {
                    for fill in Card.Fill.all {
                        let card = Card(color, number, shape, fill)
                        deck += [card]
                    }
                }
            }
        }
        for _ in 1...4 {
            drawThreeToDeck()
        }
    }
}

extension Array {
    var randomIndex: Int {
        return Int(arc4random_uniform(UInt32(count - 1)))
    }
}
