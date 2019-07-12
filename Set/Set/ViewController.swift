//
//  ViewController.swift
//  Set
//
//  Created by 汤佳桦 on 2019/7/10.
//  Copyright © 2019 Beijing Institute of Technology. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var deck = SetDeck()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    //static var last_time = false
    //static var selected = 0
    @IBOutlet var cardButton: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButton.firstIndex(of: sender){
            deck.chooseCard(at: cardNumber)
            if(deck.chosenCards.count == 3){
                deck.check()
            }
            else{
                deck.reset()
            }
            updateView()
            
        }
    }
    
    @IBAction func threeMore(_ sender: UIButton) -> Void {
        if deck.chosenCards.count >= 3 , deck.check()
        {
            deck.replace()
            updateView()
            return
        }
        if(deck.cardsOnDeck.count < 24){
            deck.add()
            updateView()
        }
    }
    
    
    
    func updateView(){
        let cardsOnDeckCount = deck.cardsOnDeck.count
        for index in deck.cardsOnDeck.indices{
            let button = cardButton[index]
            let card = deck.cardsOnDeck[index]
            
            //显示自己的图像
            button.setAttributedTitle(setCardTitle(with: deck.cardsOnDeck[index]), for: .normal)
            
            //显示是否被选中
            if(card.chosen){
                button.layer.borderWidth = 3.0
                button.layer.borderColor = UIColor.blue.cgColor
                if(card.matched == 1){
                    button.layer.borderColor = UIColor.green.cgColor
                }
                if(card.matched == -1){
                    button.layer.borderColor = UIColor.red.cgColor
                }
            }
            else{
                button.layer.borderWidth = 0.0
            }
            if(card.hide == true){
                button.isHidden = true
            }
        }
        for index in cardButton.indices{
            cardButton[index].alpha = 1
        }
        if(cardsOnDeckCount < 24){
            for index in cardsOnDeckCount...23{
                cardButton[index].alpha = 0.1
            }
        }
    }
    
    private func setCardTitle(with card: Card) -> NSAttributedString {
        
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeColor: ModelToView.colors[card.color]!,
            .strokeWidth: ModelToView.strokeWidth[card.border]!,
            .foregroundColor: ModelToView.colors[card.color]!.withAlphaComponent(ModelToView.borders[card.border]!),
            NSAttributedString.Key.font:UIFont.systemFont(ofSize: 20)
        ]
        var cardTitle = ModelToView.shapes[card.shape]!
        
        switch card.number {
        case -1: cardTitle = "\(cardTitle)"
        case 0: cardTitle = "\(cardTitle)\(cardTitle)"
        case 1: cardTitle = "\(cardTitle)\(cardTitle)\(cardTitle)"
        default:
            break
        }
        
        return NSAttributedString(string: cardTitle, attributes: attributes)
    }
}


struct ModelToView {
    static let shapes: [Int: String] = [-1: "●", 0: "▲", 1: "■"]
    static var colors: [Int: UIColor] = [-1: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), 0: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), 1: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
    static var borders: [Int: CGFloat] = [-1: 1.0, 0: 0.40, 1: 0.15]
    static var strokeWidth: [Int: CGFloat] = [-1: -5, 0: 5, 1: -5]
}
