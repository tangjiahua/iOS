//
//  test.swift
//  Homework_3
//
//  Created by 汤佳桦 on 2019/7/13.
//  Copyright © 2019 Beijing Institute of Technology. All rights reserved.
//

import Foundation

struct Stack<Element> {  //使用泛型让栈能存储各种元素
    var items = [Element]()
    mutating func push(_ item: Element) {  //入栈
        items.append(item)
    }
    
    mutating func pop() -> Element?{  //出栈
        if items.count < 1 {
            return nil
        }
        return items.removeLast()
    }
}

func getPriority(ch: String)->Int
{
    //获取优先级
    if (ch == "(") {
        return 1}
    else if (ch == "+" || ch == "-") {return 2}
    else if (ch == "*" || ch == "/") {return 3}
    else {return 4}
}

func calculate(mystack: Stack<Double>, operation: String)
{
    var num1: Double, num2:Double, num3: Double
    num2 = mystack.pop()
    num1 = mystack.pop()
    
    if (operation == "+") {
        num3 = num1 + num2;
    }
    else if (operation == "-") {
        num3 = num1 - num2;
    }
    else if (operation == "*") {
        num3 = num1 * num2;
    }
    else if (operation == "/") {
        num3 = num1 / num2;
    }
    
    mystack.push(num3)
}

func calculator(str: String) -> Double
{
    //计算中缀表达式,默认输入是合法的
    stack<double> mystack_number
    stack<char> mystack_operation
    int i = 0, j
    int size = str.size()
    char tmp_operation
    string tmp_num
    while (i < size) {
        if (str[i] >= '0' && str[i] <= '9') {
            j = i
            while (j < size && str[j] >= '0' && str[j] <= '9') { j++ }
            tmp_num = str.substr(i, j - i)
            mystack_number.push(atoi(tmp_num.c_str()))
            i = j
        }
        else if (str[i] == '+' || str[i] == '-' || str[i] == '*' || str[i] == '/') {
            if (mystack_operation.empty()) {
                mystack_operation.push(str[i])
            }
            else {
                while (!mystack_operation.empty()) {
                    tmp_operation = mystack_operation.top()
                    if (getPriority(tmp_operation) >= getPriority(str[i])) {
                        //计算
                        calculate(mystack_number, tmp_operation)
                        mystack_operation.pop()
                    }
                    else break
                }
                mystack_operation.push(str[i]);
            }
            i++;
        }
        else {
            if (str[i] == '(') mystack_operation.push(str[i])
            else {
                while (mystack_operation.top() != "(" {
                    tmp_operation = mystack_operation.top()
                    //计算
                    calculate(mystack_number, tmp_operation)
                    mystack_operation.pop()
                }
                mystack_operation.pop()
            }
            i++
        }
        
    }
    //遍历完后，若栈非空，弹出所有元素
    while (!mystack_operation.empty()) {
        tmp_operation = mystack_operation.top()
        //计算
        calculate(mystack_number, tmp_operation)
        mystack_operation.pop()
    }
    return mystack_number.top()
}
