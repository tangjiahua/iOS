//
//  Library.swift
//  Homework_2.1
//
//  Created by 汤佳桦 on 2019/7/12.
//  Copyright © 2019 Beijing Institute of Technology. All rights reserved.
//

import Foundation
class Library{
    var decks = [Deck]()
    
    func printAllBooks(){
        for deckIndex in decks.indices{
            let deck = decks[deckIndex]
            for bookIndex in deck.books.indices{
                print("Book Name: \(deck.books[bookIndex].name)  Book Code: \(deck.books[bookIndex].code)")
            }
        }
    }
    
    func findBookByCode(code: String) -> Void{
        for deckIndex in decks.indices{
            let deck = decks[deckIndex]
            for bookIndex in deck.books.indices{
                if(deck.books[bookIndex].code == code){
                    print("Yes! There is the book you need!")
                    print("It is in the deck \(deckIndex)")
                    return
                }
            }
        }
        print("Sorry, there is no book you need")
    }
    
    func findBookByName(name: String) -> Void{
        for deckIndex in decks.indices{
            let deck = decks[deckIndex]
            for bookIndex in deck.books.indices{
                if(deck.books[bookIndex].name.contains(name)){
                    print("Yes! There is the book you need!")
                    print("It is in the deck \(deckIndex)")
                    return
                }
            }
        }
        print("Sorry, there is no book you need")
    }
    
    func addDeck(name: String){
        let deckCount = decks.count
        decks.append(Deck(deckNumber: deckCount))
    }
    
    init() {
        for x in 1...5{
            decks.append(Deck(deckNumber: x))
        }
        decks[0].addBook(name: "C Primer Plus", code: "0safad0f9")
        decks[0].addBook(name: "Swift", code: "76dsf67afds")
        decks[3].addBook(name: "Objective-C", code: "sda7f68sda68f")
    }
}
