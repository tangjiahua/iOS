//
//  Cal.swift
//  Homework_3
//
//  Created by 汤佳桦 on 2019/7/13.
//  Copyright © 2019 Beijing Institute of Technology. All rights reserved.
//

import Foundation
//#include<iostream>
//#include<stack>
//#include<cstring>
//#include<iomanip>
//using namespace std;
char endnumber[100];//数字和字符栈
char number[100];//两位数特殊下标
int z = 0;//下标
//a,b优先级比较
bool cmp(char a,char b)
{
    if(a == '*'||a == '/')
    {
        if(b == '*'||b == '/')
        {
            return false;
        }
        else
        {
            return true;
        }
    }
    else
    {
        return false;
    }
}
//使用过渡栈存入后缀表达式
void get_stack(string s)
{
    memset(number,1,sizeof(number));
    stack<char>attitude;
    int l = s.length();
    int i = 0;
    for(i = 0;i < l;i++)
    {
        char t = s[i];
        if(t == '(')
        {
            attitude.push(t);
        }
        else if(t == ')')
        {
            char str1 = attitude.top();
            while(str1 != '(')
            {
                endnumber[z++] = str1;
                attitude.pop();
                str1 =     attitude.top();
            }
            attitude.pop();
        }
        else if(t >= '0'&&t <= '9')
        {
            if(s[i+1] >= '0'&&s[i+1] <= '9')
            {
                number[z] = '0';
                endnumber[z] = s[i];
                z++;
                endnumber[z] = s[i+1];
                z++;
                i++;
            }
            else
            {
                endnumber[z++] = s[i];
            }
        }
        else
        {
            if(attitude.empty())
            {
                attitude.push(t);
            }
            else
            {
                char str2 = attitude.top();
                if(cmp(t,str2) || str2 == '(')
                {
                    attitude.push(t);
                }
                else
                {
                    while(!cmp(t,str2)&&str2 != '('&&!attitude.empty())
                    {
                        attitude.pop();
                        endnumber[z++] = str2;
                        if(!attitude.empty())
                        str2 = attitude.top();
                    }
                    attitude.push(t);
                }
            }
        }
    }
    while(!attitude.empty())
    {
        char str3 = attitude.top();
        endnumber[z++] = str3;
        attitude.pop();
    }
    //    for(i = 0;i < z;i++)
    //    cout<<endnumber[i]<<" ";
}
//从存储中调出数字和字符进行计算,转换成浮点数计算精确值

void get_calculate(string s)
{
    int k = 1;
    stack<float>put_stack;
    if(number[0] == '0')
    {
        put_stack.push(((endnumber[0] - '0')*10+(endnumber[1]-'0'))*1.0);
        k++;
    }
    else
    put_stack.push(1.0*(endnumber[0] - '0'));
    for(int i = k;i < z;i++)
    {
        char t = endnumber[i];
        if(t >= '0'&&t <= '9')
        {
            if(number[i] == '0')
            {
                put_stack.push(((endnumber[i] - '0')*10+(endnumber[i+1]-'0'))*1.0);
                i++;
            }
            else
            {
                put_stack.push((t - '0')*1.0);
            }
        }
        else
        {
            float x = put_stack.top();
            put_stack.pop();
            float y = put_stack.top();
            put_stack.pop();
            float tmp;
            if(t == '+')
            tmp = x+y;
            else if(t == '-')
            tmp = y-x;
            else if(t == '*')
            tmp = x*y;
            else
            tmp = y/x;
            put_stack.push(tmp);
        }
    }
    cout<<setiosflags(ios::fixed)<<setprecision(2)<<put_stack.top();
}
int main()
    {
        string exp_middle;//中缀表达式
        cin>>exp_middle;
        get_stack(exp_middle);
        get_calculate(exp_middle);
        return 0;
}
