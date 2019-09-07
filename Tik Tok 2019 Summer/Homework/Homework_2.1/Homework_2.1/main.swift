//
//  main.swift
//  Homework_2.1
//
//  Created by 汤佳桦 on 2019/7/12.
//  Copyright © 2019 Beijing Institute of Technology. All rights reserved.
//

import Foundation
var library = Library()
print("The Library built!")
library.printAllBooks()
library.findBookByCode(code: "0safad0f9")
library.findBookByName(name: "Swi")
library.findBookByName(name: "Objective-C")
library.decks[3].addBook(name: "Java", code: "dsfsayy786dsaf")
