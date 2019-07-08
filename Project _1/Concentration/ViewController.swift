//
//  ViewController.swift
//  Concentration
//
//  Created by jamfly on 2017/12/26.
//  Copyright © 2017年 jamfly. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardsButton.count + 1) / 2
    }
    
    private(set) var flipCount = 0 {
        didSet {
            countLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBAction func StartNewGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        updateViewFromModel()
        flipCount = 0
        check = [0, 0, 0, 0, 0, 0, 0,0,0,0,0,0]
        i = 0
        t = emojiChoices.count.arc4random
    }
    
    
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private var cardsButton: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardsButton.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    
    private func updateViewFromModel() {
        for index in cardsButton.indices {
            let button = cardsButton[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
                
            }
        }
    }
    
    private var emoji_faces = ["😀","😅","😇","😢","😳","🤓","😜","😠","😫","🧐","🥰","😍"]
    private var emoji_animals = ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐼","🐨","🐯","🦁","🐮"]
    private var emoji_flags = ["🏳️","🏴","🏴‍☠️","🏁","🚩","🏳️‍🌈","🇺🇳","🇦🇫","🇦🇽","🇦🇱","🇩🇿","🇦🇸"]
    private var emoji_fruit = ["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓","🍈","🍒","🍑"]
    private var emoji_buildings = ["⛩","🕋","🕍","🕌","⛪️","🏛","💒","🏩","🏫","🏪","🏨","🏦"]
    private var emoji_ramdom = ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎", "🐜", "🐍", "🦀"]
    
    lazy private var emojiChoices = [emoji_animals, emoji_faces,emoji_flags, emoji_fruit, emoji_buildings, emoji_ramdom]
    
    private var emoji = [Int: String]()
    
    lazy private var t = emojiChoices.count.arc4random
    
    var i = 0
    var check = [0, 0, 0, 0, 0, 0,0,0,0,0,0,0]
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil{
            i = 0
            while(check[i] != 0){
                i = emojiChoices[t].count.arc4random
            }
            check[i] = 1
            emoji[card.identifier] = emojiChoices[t][i]
        }
        return emoji[card.identifier] ?? "?"
    }
    
    
}

// MARK: extention
extension Int {
    
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
        
    }
    
    
}












