//
//  ViewController.swift
//  Homework_3
//
//  Created by 汤佳桦 on 2019/7/13.
//  Copyright © 2019 Beijing Institute of Technology. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var calculator = Calculator()
    
    @IBOutlet var Button: [UIButton]!
    
    override func viewDidLoad() {
        for index in 1...18{
            let button = Button[index]
            button.layer.masksToBounds = true
            Button[index].layer.cornerRadius = Button[index].frame.size.width/2
        }
        Button[0].layer.masksToBounds = true
        Button[0].layer.cornerRadius = Button[0].frame.size.width/4
    }
    
    @IBAction func touchButton(_ sender: UIButton) {
        switch Button.firstIndex(of: sender)! {
        case 0: calculator.touch(symbol: "0")
        case 1: calculator.touch(symbol: "1")
        case 2: calculator.touch(symbol: "2")
        case 3: calculator.touch(symbol: "3")
        case 4: calculator.touch(symbol: "4")
        case 5: calculator.touch(symbol: "5")
        case 6: calculator.touch(symbol: "6")
        case 7: calculator.touch(symbol: "7")
        case 8: calculator.touch(symbol: "8")
        case 9: calculator.touch(symbol: "9")
        case 10: calculator.touch(symbol: "AC")
        case 11: calculator.touch(symbol: "(")
        case 12: calculator.touch(symbol: ")")
        case 13: calculator.touch(symbol: "/")
        case 14: calculator.touch(symbol: "*")
        case 15: calculator.touch(symbol: "+")
        case 16: calculator.touch(symbol: "-")
        case 17: calculator.touch(symbol: "=")
        case 18: calculator.touch(symbol: ".")
        default: break
        }
        Text.text = String(calculator.text)
    }
    
    
    @IBOutlet weak var Text: UILabel!
    
    
    
}
