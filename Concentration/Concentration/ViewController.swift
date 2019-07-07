//
//  ViewController.swift
//  Concentration
//
//  Created by 汤佳桦 on 2019/6/27.
//  Copyright © 2019 BIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game: Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
     var numberOfPairsOfCards: Int{
        get{
            return (cardButtons.count+1)/2
        }
    }
    
    private(set) var flipCount = 0{
        didSet{
             CounterLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet private  weak var CounterLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("chosen card was not in cardBUttons")
        }
        
    }
    
    private func updateViewFromModel(){
        for index in cardButtons.indices{
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceup{
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMactched ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    private var emojiChoice = ["🧧", "🎃", "👻", "🥰","🐭","🕷", "🐞", "🏀","🐵"]
    
    
   private var emoji = [Card: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoice.count > 0 {
            emoji[card] = emojiChoice.remove(at: emojiChoice.count.arc4ramdom)
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4ramdom: Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))

        }
        else if self < 0{
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        else{
            return 0
        }
    }
}
