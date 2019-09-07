//
//  Calculate.cpp
//  Homework_3
//
//  Created by 汤佳桦 on 2019/7/13.
//  Copyright © 2019 Beijing Institute of Technology. All rights reserved.
//

#include "Calculate.hpp"
#include<iostream>
#include<string>
#include<stack>

using namespace std;

    func getPriority(char ch)->int
    {
        //获取优先级
        if (ch == '(') return 1;
        else if (ch == '+' || ch == '-') return 2;
        else if (ch == '*' || ch == '/') return 3;
        else return 4;
    }
    
    void calculate(stack<double> &mystack, char operation)
    {
        double num1, num2, num3;
        num2 = mystack.top();
        mystack.pop();
        num1 = mystack.top();
        mystack.pop();
        if (operation == '+') {
            num3 = num1 + num2;
        }
        else if (operation == '-') {
            num3 = num1 - num2;
        }
        else if (operation == '*') {
            num3 = num1 * num2;
        }
        else if (operation == '/') {
            num3 = num1 / num2;
        }
        
        mystack.push(num3);
    }
    
    double calculator(string str)
    {
        //计算中缀表达式,默认输入是合法的
        stack<double> mystack_number;
        stack<char> mystack_operation;
        int i = 0, j;
        int size = str.size();
        char tmp_operation;
        string tmp_num;
        while (i < size) {
            if (str[i] >= '0' && str[i] <= '9') {
                j = i;
                while (j < size && str[j] >= '0' && str[j] <= '9') { j++; }
                tmp_num = str.substr(i, j - i);
                mystack_number.push(atoi(tmp_num.c_str()));
                i = j;
            }
            else if (str[i] == '+' || str[i] == '-' || str[i] == '*' || str[i] == '/') {
                if (mystack_operation.empty()) {
                    mystack_operation.push(str[i]);
                }
                else {
                    while (!mystack_operation.empty()) {
                        tmp_operation = mystack_operation.top();
                        if (getPriority(tmp_operation) >= getPriority(str[i])) {
                            //计算
                            calculate(mystack_number, tmp_operation);
                            mystack_operation.pop();
                        }
                        else break;
                    }
                    mystack_operation.push(str[i]);
                }
                i++;
            }
            else {
                if (str[i] == '(') mystack_operation.push(str[i]);
                else {
                    while (mystack_operation.top() != '(') {
                        tmp_operation = mystack_operation.top();
                        //计算
                        calculate(mystack_number, tmp_operation);
                        mystack_operation.pop();
                    }
                    mystack_operation.pop();
                }
                i++;
            }
            
        }
        //遍历完后，若栈非空，弹出所有元素
        while (!mystack_operation.empty()) {
            tmp_operation = mystack_operation.top();
            //计算
            calculate(mystack_number, tmp_operation);
            mystack_operation.pop();
        }
        return mystack_number.top();
    }

