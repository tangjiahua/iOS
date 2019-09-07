//
//  Teacher.swift
//  Demo
//
//  Created by 汤佳桦 on 2019/7/12.
//  Copyright © 2019 Beijing Institute of Technology. All rights reserved.
//

import Foundation
class Teacher: NSObject {
    
    var student: Student?
    var isRight: Bool? // 答案是否正确
    
    override init() {
        super.init()
        
        student = Student()
        // 闭包回调
        student?.giveAnswerClosure = { answer in
            // 答案是1
            self.isRight = answer == 1 ? true : false
        }
    }
    
    // 提问问题
    func askQuestion() {
        // 学生回答
        student?.giveAnswer()
    }
    
    deinit {
        print("deinit---Teacher")
    }
}
