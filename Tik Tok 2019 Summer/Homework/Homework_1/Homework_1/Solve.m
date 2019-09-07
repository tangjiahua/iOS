//
//  Solve.m
//  Homework_1
//
//  Created by 汤佳桦 on 2019/7/15.
//  Copyright © 2019 Beijing Institute of Technology. All rights reserved.
//

#import "Solve.h"

@implementation Solve


-(void)get{
    NSInteger previous = -1;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"input" ofType:@"txt"];
    
    NSString *input = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    _myindegree = [NSMutableDictionary dictionary];
    _myhash = [NSMutableDictionary dictionary];
    
    NSString *t = @"\n";
    NSRange myrange;
    for(int i=0; i<input.length; i+=myrange.length){
        myrange = [input rangeOfComposedCharacterSequenceAtIndex:i];
        NSString *s = [input substringWithRange:myrange];
        NSString * mytemp,* cur;
        NSMutableArray * arr;
        if ([t isEqualToString:s])
        {
            for (int j=previous+1 ; j<i ; j++)
            {
                for (int k=j+1 ; k<i ; k++)
                {
                    NSRange range_1 = {j,1};
                    cur = [input substringWithRange:range_1];
                    NSRange range = {k,1};
                    mytemp = [input substringWithRange:range];
                    arr = [[NSMutableArray array]init];
                    if ([_myhash[cur]count]==0) {
                        _myhash[cur] = arr;
                    }
             
                    if (![_myhash[cur] containsObject:mytemp] && !([cur isEqualToString:mytemp])) {
                        [_myhash[cur] addObject:mytemp];
                    }
                }
                
            }
            previous = i;
            continue;
        }
        
   
        _myindegree[s] = @(0);//存储入度
    }
    
    for (NSString *key in _myhash) {
        NSArray *value = _myhash[key];
        for (NSString * ch in value) {
            int num = [_myindegree[ch]intValue];
            _myindegree[ch] = @(num+1);
        }
    }
    
    for (NSString *key in _myindegree) {
        NSString *value = _myindegree[key];
    }
}

-(void)solve{
    NSInteger myflag = 0;     
    NSInteger num = [_myindegree count];
    NSInteger pp = 0;
    NSMutableDictionary *mydictionary = [_myindegree mutableCopy];
    
    for(NSInteger k=0 ; k<num ; k++)//输出chnum次字符
    {
        myflag = 0;
        NSArray *keysArray = [mydictionary allKeys];
        for (int i = 0; i < keysArray.count; i++)
        {
            NSString *key = keysArray[i];
            NSNumber *value = mydictionary[key];
            if ([value intValue]==0)
            {
                myflag = 1;
                NSLog(@"%@",key);
                pp ++;
                NSArray *value1 = _myhash[key];
                for (NSString *ch in value1)
                {
                    int num = [_myindegree[ch]intValue];
                    _myindegree[ch] = @(num-1);
                }
                [_myindegree removeObjectForKey:key];
            }
        }
        mydictionary = _myindegree;
    }
    
}
@end
