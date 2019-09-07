//
//  Deck.swift
//  Homework_2.1
//
//  Created by 汤佳桦 on 2019/7/12.
//  Copyright © 2019 Beijing Institute of Technology. All rights reserved.
//

import Foundation
class Deck{
    var deckNumber:Int
    var books = [Book]()
    
    func addBook(name: String, code: String){
        books.append(Book(name: name, code: code))
        print("Yes, you add a book in Deck \(deckNumber)")
    }
    
    init(deckNumber: Int) {
        self.deckNumber = deckNumber
    }
}
