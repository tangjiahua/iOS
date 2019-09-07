//
//  Calculator.swift
//  Homework_3
//
//  Created by 汤佳桦 on 2019/7/13.
//  Copyright © 2019 Beijing Institute of Technology. All rights reserved.
//

import Foundation
class Calculator{
    var text = 0
    var text_pre = 0
    var symbol = "!"
    var dot = 0
    
    func touch(symbol: String){
        if(dot == 0)
        {
            switch symbol {
            case "0": text = text*10
            case "1": text = text*10 + 1
            case "2": text = text*10 + 2
            case "3": text = text*10 + 3
            case "4": text = text*10 + 4
            case "5": text = text*10 + 5
            case "6": text = text*10 + 6
            case "7": text = text*10 + 7
            case "8": text = text*10 + 8
            case "9": text = text*10 + 9
            case "AC":
                text = 0
            case "=":do{
                switch self.symbol{
                case "+":do{
                    text = text + text_pre
                    text_pre = 0
                    self.symbol = "!"
                    }
                case "-": do{
                    text = text_pre - text
                    text_pre = 0
                    self.symbol = "!"
                    }
                case "*": do{
                    text = text * text_pre
                    text_pre = 0
                    self.symbol = "!"
                    }
                case "/": do{
                    text = text / text_pre
                    text_pre = 0
                    self.symbol = "!"
                    }
                case "!": do{
                    break
                    }
                default: break
                }
                break
                }
                
            case "+":do {
                self.symbol = "+"
                self.text_pre = self.text
                self.text = 0
                }
            case "-": do {
                self.symbol = "-"
                self.text_pre = self.text
                self.text = 0
                }
            case "*": do {
                self.symbol = "*"
                self.text_pre = self.text
                self.text = 0
                }
            case "/": do {
                self.symbol = "/"
                self.text_pre = self.text
                self.text = 0
                }
                
            default:
                print("Sorry It's a bug!")
            }
        }
    }
    
    init() {
        text = 0
        text_pre = 0
        symbol = "+"
    }
}
