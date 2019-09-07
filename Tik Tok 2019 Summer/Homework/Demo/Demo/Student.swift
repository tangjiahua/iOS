//
//  Student.swift
//  Demo
//
//  Created by 汤佳桦 on 2019/7/12.
//  Copyright © 2019 Beijing Institute of Technology. All rights reserved.
//

import Foundation
class Student {
    
    var name: String?
    var giveAnswerClosure: ((Int) -> Void)?
    
    // 学生回答问题
    func giveAnswer() {
        // 调用闭包给出答案
        giveAnswerClosure?(1)
    }
    
    deinit {
        print("deinit---Student")
    }
}
